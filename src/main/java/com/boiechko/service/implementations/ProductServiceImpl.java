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
    public List<Product> getProductsByColumnInRandomOrder(final String column, final String credentials) {
        return productDao.getProductsByColumnInRandomOrder(column, credentials);
    }

    @Override
    public List<Product> getLatestAddedProducts() {
        return productDao.getLatestAddedProducts();
    }

    @Override
    public List<Product> getUniqueProductNames(final String typeName, final String sex) {

        return productDao.getProductsByColumnInRandomOrder("typeName", typeName)
                .stream()
                .filter(product -> product.getSex().equals(getUkrainianSex(sex)))
                .filter(distinctByKey(Product::getProductName))
                .collect(Collectors.toList());

    }

    private static <T> Predicate<T> distinctByKey(Function<? super T, ?> keyExtractor) {
        Set<Object> seen = ConcurrentHashMap.newKeySet();
        return product -> seen.add(keyExtractor.apply(product));
    }

    @Override
    public List<Product> groupByColumn(final String column) {
        return productDao.groupByColumn(column);
    }

    @Override
    public List<Product> getPopularBrands() {

        return groupByColumn("brand").stream()
                .map(Product::getBrand)
                .map(brand -> getProductsByColumnInRandomOrder("brand", brand))
                .filter(products -> products.size() >= 10)
                .map(products -> products.get(0))
                .sorted(Comparator.comparing(Product::getBrand))
                .collect(Collectors.toList());

    }

    @Override
    public List<Product> getProductsThatUserMayLike(final Product product) {
        return productDao.getProductsByColumnInRandomOrder("productName", product.getProductName())
                .stream()
                .filter(element -> !element.equals(product))
                .limit(4)
                .collect(Collectors.toList());
    }

    @Override
    public List<Product> getProductsBySex(final List<Product> products, final String sex) {

        return products
                .stream()
                .filter(product -> product.getSex().equals(getUkrainianSex(sex)))
                .collect(Collectors.toList());

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
}
