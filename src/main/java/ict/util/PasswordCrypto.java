package ict.util;
import javax.crypto.Cipher;
import javax.crypto.spec.IvParameterSpec;
import javax.crypto.spec.SecretKeySpec;
import java.util.Base64;
import java.util.Arrays;

public class PasswordCrypto {
    private static final String ALGORITHM = "AES";
    private static final String TRANSFORMATION = "AES/CBC/PKCS5Padding";
    private static final String SECRET_KEY = "MySecretKey12345"; // 16 bytes
    private static final int IV_LENGTH = 16; // AES requires 16-byte IV

    // Class to hold encryption result (encrypted text + IV)
    public static class CryptoResult {
        public final String encryptedText;
        public final String iv;

        public CryptoResult(String encryptedText, String iv) {
            this.encryptedText = encryptedText;
            this.iv = iv;
        }
    }

    // Encrypt a password with user-provided IV
    public static CryptoResult encrypt(String password, String userIv) throws Exception {
        // Normalize IV to 16 bytes
        byte[] ivBytes = normalizeIv(userIv.getBytes("UTF-8"));
        IvParameterSpec ivSpec = new IvParameterSpec(ivBytes);

        SecretKeySpec keySpec = new SecretKeySpec(SECRET_KEY.getBytes("UTF-8"), ALGORITHM);
        Cipher cipher = Cipher.getInstance(TRANSFORMATION);
        cipher.init(Cipher.ENCRYPT_MODE, keySpec, ivSpec);

        byte[] encryptedBytes = cipher.doFinal(password.getBytes("UTF-8"));
        String encryptedText = Base64.getEncoder().encodeToString(encryptedBytes);
        String ivBase64 = Base64.getEncoder().encodeToString(ivBytes);

        return new CryptoResult(encryptedText, ivBase64);
    }

    // Decrypt a password
    public static String decrypt(String encryptedText, String ivBase64) throws Exception {
        byte[] iv = Base64.getDecoder().decode(ivBase64);
        IvParameterSpec ivSpec = new IvParameterSpec(iv);

        SecretKeySpec keySpec = new SecretKeySpec(SECRET_KEY.getBytes("UTF-8"), ALGORITHM);
        Cipher cipher = Cipher.getInstance(TRANSFORMATION);
        cipher.init(Cipher.DECRYPT_MODE, keySpec, ivSpec);

        byte[] decryptedBytes = cipher.doFinal(Base64.getDecoder().decode(encryptedText));
        return new String(decryptedBytes, "UTF-8");
    }

    // Helper method to normalize IV to 16 bytes
    private static byte[] normalizeIv(byte[] inputIv) {
        byte[] normalizedIv = new byte[IV_LENGTH];
        
        if (inputIv.length == IV_LENGTH) {
            return inputIv;
        }
        
        // If IV is shorter, pad with zeros
        // If IV is longer, truncate
        if (inputIv.length < IV_LENGTH) {
            System.arraycopy(inputIv, 0, normalizedIv, 0, inputIv.length);
            Arrays.fill(normalizedIv, inputIv.length, IV_LENGTH, (byte) 0);
        } else {
            System.arraycopy(inputIv, 0, normalizedIv, 0, IV_LENGTH);
        }
        
        return normalizedIv;
    }
}