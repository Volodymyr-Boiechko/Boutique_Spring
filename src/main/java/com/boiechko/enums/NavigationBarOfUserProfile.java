package com.boiechko.enums;

public enum NavigationBarOfUserProfile {

    PROFILE(1), ORDERS(2), PERSON_INFO(3), PERSON_CHANGE_PASSWORD(4),
    ADDRESSES_OF_PERSON(5), UNDEFINED(-1);

    int numberOfSection;

    NavigationBarOfUserProfile(int numberOfSection) {
        this.numberOfSection = numberOfSection;
    }

    public int getNumberOfSection() {
        return numberOfSection;
    }

}
