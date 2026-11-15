package ma.app.listener;

import jakarta.servlet.ServletContext;
import jakarta.servlet.ServletContextEvent;
import jakarta.servlet.ServletContextListener;
import jakarta.servlet.annotation.WebListener;

import ma.app.model.ProduitDAO;

@WebListener
public class AppInitListener implements ServletContextListener {

    @Override
    public void contextInitialized(ServletContextEvent sce) {
        ServletContext context = sce.getServletContext();
        ProduitDAO dao = new ProduitDAO();

        context.setAttribute("produitDAO", dao);
        System.out.println("ProduitDAO initialisé !");
    }
}
