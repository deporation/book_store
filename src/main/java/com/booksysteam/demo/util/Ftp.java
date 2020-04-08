package com.booksysteam.demo.util;
 
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;

import org.apache.commons.net.ftp.FTPClient;
import org.apache.commons.net.ftp.FTPClientConfig;
 
/**
 * FTP实例
 */
public class Ftp {
 
    public static boolean download(FTPClient ftpClient, String source, String dest) {
        boolean flag = false;
        try (OutputStream outputStream = Files.newOutputStream(Paths.get(dest))) {
            flag = ftpClient.retrieveFile(source, outputStream);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return flag;
    }
 
    public static boolean upload(FTPClient ftpClient, String source, String dest) {
        boolean flag = false;
        Path path = Paths.get(source);
        try (InputStream inputStream = Files.newInputStream(path)) {
            ftpClient.changeWorkingDirectory(dest);
            flag = ftpClient.storeFile(path.getFileName().toString(), inputStream);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return flag;
    }
 
    public static FTPClient getFTPClient(String server, String username, String password) throws IOException {
        FTPClient ftpClient = new FTPClient();
        FTPClientConfig config = new FTPClientConfig();
        config.setServerTimeZoneId("Asia/Shanghai");
        ftpClient.configure(config);
        ftpClient.connect(server);
        ftpClient.login(username, password);
        return ftpClient;
    }
}