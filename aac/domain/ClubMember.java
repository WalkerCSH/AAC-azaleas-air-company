package aac.domain;

import aac.domain.dataCategory.AACException;

public class ClubMember extends Customer {

    private String password;

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) throws AACException {
        if (password == null) {
            System.out.println("密碼為必要欄位!");
            throw new AACException("密碼為必要欄位!");
        } else if ((password = password.trim()).length() >= 6
                && password.length() <= 20) {
            System.out.println("密碼長度必須在6~20之間!");
            throw new AACException("密碼長度必須在6~20之間!");
        } else {
            this.password = password;
        }
    }

}
