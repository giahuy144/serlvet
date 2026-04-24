import org.apache.catalina.Context;
import org.apache.catalina.WebResourceRoot;
import org.apache.catalina.startup.Tomcat;
import org.apache.catalina.webresources.DirResourceSet;
import org.apache.catalina.webresources.StandardRoot;
import java.io.File;

public class Main {
    public static void main(String[] args) throws Exception {
        Tomcat tomcat = new Tomcat();
        int port = 9090;
        tomcat.setPort(port);
//kkk
        // QUAN TRỌNG: Phải có dòng này để Tomcat mở cổng 9090
        tomcat.getConnector();

        // Xác định đường dẫn tuyệt đối đến webapp
        String webDir = new File("src/main/webapp").getAbsolutePath();
        System.out.println("Cấu hình Webapp tại: " + webDir);

        if (!new File(webDir).exists()) {
            System.err.println("LỖI: Không tìm thấy thư mục webapp tại: " + webDir);
        }

        Context ctx = tomcat.addWebapp("", webDir);

        // Thêm cấu hình để Tomcat tìm thấy các class đã biên dịch (cho annotation scanning)
        File additionWebInfClasses = new File("build/classes/java/main");
        if (additionWebInfClasses.exists()) {
            WebResourceRoot resources = new StandardRoot(ctx);
            resources.addPreResources(new DirResourceSet(resources, "/WEB-INF/classes",
                    additionWebInfClasses.getAbsolutePath(), "/"));
            ctx.setResources(resources);
            System.out.println("Đã cấu hình resources từ: " + additionWebInfClasses.getAbsolutePath());
        } else {
            System.err.println("CẢNH BÁO: Không tìm thấy thư mục build/classes/java/main. Hãy chắc chắn bạn đã chạy 'gradle build'.");
        }

        System.out.println("Đang khởi động Server...");
        tomcat.start();
        System.out.println(">>> SERVER ĐANG CHẠY TẠI: http://localhost:" + port + " <<<");

        tomcat.getServer().await();
    }
}
