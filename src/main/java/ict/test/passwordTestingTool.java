/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package ict.test;

import ict.db.ProjectDB;
import java.util.*;
import ict.bean.*;
import ict.util.*;
import java.io.UnsupportedEncodingException;
import java.time.LocalDate;

/**
 *
 * @author Wai Lim Fung
 */
public class passwordTestingTool {

        public static void main(String[] arg) throws UnsupportedEncodingException, Exception {
                String url = "jdbc:mysql://localhost:3306/ITP4511_Project_DB";
                String username = "root";
                String password = "";
                ProjectDB db = new ProjectDB(url, username, password);

                 try {
                 //Encrypt with different IV lengths
                 PasswordCrypto.CryptoResult result1 = PasswordCrypto.encrypt("123456",
                 "U011");
                 System.out.println("Encrypted Text 1: " + result1.encryptedText);
                 System.out.println("IV 1: " + result1.iv);
                
                 // Decrypt
                 String decrypted1 = PasswordCrypto.decrypt("XZw5jE83h5G9qaALwfg7qg==",
                 "VTAwNAAAAAAAAAAAAAAAAA==");
                 System.out.println("Decrypted Text 1: " + decrypted1);
                
                 } catch (Exception e) {
                 e.printStackTrace();
                 }
              
        }
}