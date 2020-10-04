package com.boiechko.service.implementations;

import com.boiechko.dao.interfaces.ProductDao;
import com.boiechko.model.Product;
import com.boiechko.service.interfaces.ProductService;
import org.apache.log4j.Logger;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.io.IOException;
import java.util.*;
import java.util.concurrent.ConcurrentHashMap;
import java.util.function.Function;
import java.util.function.Predicate;
import java.util.stream.Collectors;

@Service
public class ProductServiceImpl implements ProductService {

    private final Logger logger = Logger.getLogger(ProductServiceImpl.class);

    private final String PATH_TO_DATABASE_IMAGES = "C:\\Users\\volod\\IdeaProjects\\Boutique_Spring\\src\\main\\webapp\\resources\\dataBaseImages\\";

    private final ProductDao productDao;

    public ProductServiceImpl(ProductDao productDao) {
        this.productDao = productDao;
    }

    @Override
    public void addProduct(final Product product) {
        productDao.add(product);
    }

    @Override
    public Product getProductById(final int idProduct) {
        return productDao.getById(idProduct);
    }

    @Override
    public List<Product> getAllProducts() {
        return productDao.getAll();
    }

    @Override
    public void updateProduct(final Product product) {
        productDao.update(product);
    }

    @Override
    public void deleteProduct(final Product product) {
        productDao.delete(product);
    }

    @Override
    public List<Product> getUniqueProductNames(final String typeName, final String sex) {

        return productDao.getProducts(typeName, null, getUkrainianSex(sex))
                .stream()
                .filter(distinctByKey(Product::getProductName))
                .collect(Collectors.toList());

    }

    private static <T> Predicate<T> distinctByKey(Function<? super T, ?> keyExtractor) {
        final Set<Object> seen = ConcurrentHashMap.newKeySet();
        return product -> seen.add(keyExtractor.apply(product));
    }

    @Override
    public List<Product> getUniqueNamesOfPopularBrands(final String sex) {

        return productDao.getProducts("Популярні бренди", null, getUkrainianSex(sex))
                .stream()
                .filter(distinctByKey(Product::getBrand))
                .collect(Collectors.toList());

    }

    @Override
    public List<Product> getProductsThatUserMayLike(final Product product, final String sex) {
        return productDao.getProducts(product.getTypeName(), product.getProductName(), getUkrainianSex(sex))
                .stream()
                .filter(element -> !element.equals(product))
                .limit(4)
                .collect(Collectors.toList());
    }

    @Override
    public boolean saveImageOfProduct(final MultipartFile image, final String destination) {

        final String imagePath = PATH_TO_DATABASE_IMAGES + destination.replace("/", "\\");

        final File fileDir = new File(imagePath);
        if (!fileDir.exists()) {

            boolean isFolderCreated = fileDir.mkdirs();

            if (!isFolderCreated) {
                logger.error("Error while creating folder");
            }

        }

        final String fileName = image.getOriginalFilename();

        if (validateImage(Objects.requireNonNull(fileName))) {
            try {
                image.transferTo(new File(imagePath + File.separator + fileName));
            } catch (IOException e) {
                logger.error(e.getMessage());
                return false;
            }
        } else {
            return false;
        }

        return true;

    }

    private boolean validateImage(final String imageName) {

        return imageName.contains("jpg") || imageName.contains("png") || imageName.contains("gif");
    }

    @Override
    public String getDestinationOfImage(final MultipartFile image, final String destination) {

        return "dataBaseImages/" + destination + "/" + image.getOriginalFilename();
    }

    @Override
    public String getUkrainianSex(final String englishSex) {

        return englishSex.equals("man") ? "Чоловічий одяг" : "Жіночий одяг";

    }

    @Override
    public String getUkrainianTypeName(final String englishTypeName) {

        switch (englishTypeName) {
            case "clothes":
                return "Одяг";
            case "shoes":
                return "Взуття";
            case "accessories":
                return "Аксесуари";
            case "sportWear":
                return "Спортивний одяг";
            case "newestClothes":
                return "Новинки";
            case "brands":
                return "Популярні бренди";
            default:
                return null;

        }

    }

    @Override
    public String getEnglishTypeName(final String ukrainianTypeName) {

        switch (ukrainianTypeName) {
            case "Одяг":
                return "clothes";
            case "Взуття":
                return "shoes";
            case "Аксесуари":
                return "accessories";
            case "Спортивний одяг":
                return "sportWear";
            default:
                return null;

        }
    }

    @Override
    public String getPathToPage(final String typeName, final String productName) {

        return productName == null ? getUkrainianTypeName(typeName) : productName;

    }
}
