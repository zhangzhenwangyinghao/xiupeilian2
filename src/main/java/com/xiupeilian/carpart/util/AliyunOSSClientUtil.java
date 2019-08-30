package com.xiupeilian.carpart.util;

import java.io.ByteArrayInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.InputStream;
import java.net.URL;
import java.util.Date;

import com.xiupeilian.carpart.constant.SysConstant;
import org.apache.log4j.Logger;

import com.aliyun.oss.OSSClient;

import com.aliyun.oss.model.ObjectMetadata;
import com.aliyun.oss.model.PutObjectResult;

/**
 * Created by wuming on 2018/2/6.
 */
public class AliyunOSSClientUtil {

    //log��־
    private static Logger logger = Logger.getLogger(AliyunOSSClientUtil.class);
    //������API���ڻ���������
    private static String ENDPOINT;
    //������API����ԿAccess Key ID
    private static String ACCESS_KEY_ID;
    //������API����ԿAccess Key Secret
    private static String ACCESS_KEY_SECRET;
    //������API��bucket����
    private static String BACKET_NAME;
    //������API���ļ�������
    private static String FOLDER;

    //��ʼ������
    static {
        ENDPOINT = SysConstant.ENDPOINT;
        ACCESS_KEY_ID = SysConstant.ACCESS_KEY_ID;
        ACCESS_KEY_SECRET = SysConstant.ACCESS_KEY_SECRET;
        BACKET_NAME = SysConstant.BACKET_NAME;
        FOLDER = SysConstant.FOLDER;
    }

    public static Logger getLogger() {
        return logger;
    }

    public static void setLogger(Logger logger) {
        AliyunOSSClientUtil.logger = logger;
    }

    /**
     * ��ȡ������OSS�ͻ��˶���
     *
     * @return ossClient
     */
    public static OSSClient getOSSClient() {
        return new OSSClient(ENDPOINT, ACCESS_KEY_ID, ACCESS_KEY_SECRET);
    }


    /**
     * �ϴ�ͼƬ��OSS
     *
     * @param ossClient  oss����
     * @param file       �ϴ��ļ����ļ�ȫ·���磺D:\\image\\cake.jpg��
     * @param bucketName �洢�ռ�
     * @param folder     ģ���ļ����� ��"qj_nanjing/"
     * @return String ���ص�ΨһMD5����ǩ��
     */
    public static String uploadObject2OSS(OSSClient ossClient, File file, String bucketName, String folder) {
        String resultStr = null;
        try {
            //������������ʽ�ϴ��ļ�
            InputStream is = new FileInputStream(file);
            //�ļ���
            String fileName = file.getName();
            //�ļ���С
            Long fileSize = file.length();
            //�����ϴ�Object��Metadata
            ObjectMetadata metadata = new ObjectMetadata();
            //�ϴ����ļ��ĳ���
            metadata.setContentLength(is.available());
            //ָ����Object������ʱ����ҳ�Ļ�����Ϊ
            metadata.setCacheControl("no-cache");
            //ָ����Object������Header
            metadata.setHeader("Pragma", "no-cache");
            //ָ����Object������ʱ�����ݱ����ʽ
            metadata.setContentEncoding("utf-8");
            //�ļ���MIME�������ļ������ͼ���ҳ���룬�������������ʲô��ʽ��ʲô�����ȡ�ļ�������û�û��ָ�������Key���ļ�������չ�����ɣ�
            //���û����չ������Ĭ��ֵapplication/octet-stream
            metadata.setContentType(getContentType(fileName));
            //ָ����Object������ʱ�����ƣ�ָʾMINME�û����������ʾ���ӵ��ļ����򿪻����أ����ļ����ƣ�
            metadata.setContentDisposition("filename/filesize=" + fileName + "/" + fileSize + "Byte.");
            //�ϴ��ļ�   (�ϴ��ļ�������ʽ)
            PutObjectResult putResult = ossClient.putObject(bucketName, folder + fileName, is, metadata);
            //�������
            resultStr = putResult.getETag();
        } catch (Exception e) {
            e.printStackTrace();
            logger.error("�ϴ�������OSS�������쳣." + e.getMessage(), e);
        }
        return resultStr;
    }

    /**
     * ͨ���ļ����жϲ���ȡOSS�����ļ��ϴ�ʱ�ļ���contentType
     *
     * @param fileName �ļ���
     * @return �ļ���contentType
     */
    public static String getContentType(String fileName) {
        //�ļ��ĺ�׺��
        String fileExtension = fileName.substring(fileName.lastIndexOf("."));
        if (".bmp".equalsIgnoreCase(fileExtension)) {
            return "image/bmp";
        }
        if (".gif".equalsIgnoreCase(fileExtension)) {
            return "image/gif";
        }
        if (".jpeg".equalsIgnoreCase(fileExtension) || ".jpg".equalsIgnoreCase(fileExtension) || ".png".equalsIgnoreCase(fileExtension)) {
            return "image/jpeg";
        }
        if (".html".equalsIgnoreCase(fileExtension)) {
            return "text/html";
        }
        if (".txt".equalsIgnoreCase(fileExtension)) {
            return "text/plain";
        }
        if (".vsd".equalsIgnoreCase(fileExtension)) {
            return "application/vnd.visio";
        }
        if (".ppt".equalsIgnoreCase(fileExtension) || "pptx".equalsIgnoreCase(fileExtension)) {
            return "application/vnd.ms-powerpoint";
        }
        if (".doc".equalsIgnoreCase(fileExtension) || "docx".equalsIgnoreCase(fileExtension)) {
            return "application/msword";
        }
        if (".xml".equalsIgnoreCase(fileExtension)) {
            return "text/xml";
        }
        //Ĭ�Ϸ�������
        return "image/jpeg";
    }

    //����
    public static void main(String[] args) {
        //��ʼ��OSSClient
        OSSClient ossClient = AliyunOSSClientUtil.getOSSClient();
        //�ϴ��ļ�
        String files = "d:\\image\\01.jpg,"
                + "d:\\image\\04.jpg";
        String[] file = files.split(",");
        for (String filename : file) {
            //System.out.println("filename:"+filename);
            File filess = new File(filename);
            String md5key = AliyunOSSClientUtil.uploadObject2OSS(ossClient, filess, BACKET_NAME, FOLDER);
            logger.info("�ϴ�����ļ�MD5����Ψһǩ��:" + md5key);
            //�ϴ�����ļ�MD5����Ψһǩ��:40F4131427068E08451D37F02021473A
        }
    }

    /**
     * ���url����
     *
     * @param key
     * @return
     */
    public static String getUrl(String key) {
        // ����URL����ʱ��Ϊ10��  3600l* 1000*24*365*10
        Date expiration = new Date(new Date().getTime() + 3600l * 1000 * 24 * 365 * 10);
        //		// ����URL
        URL url = getOSSClient().generatePresignedUrl(BACKET_NAME, key, expiration);
        if (url != null) {
            return url.toString();
        }
        return null;
    }
}