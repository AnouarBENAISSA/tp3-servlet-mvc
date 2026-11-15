package ma.app.web;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import ma.app.model.Produit;
import ma.app.model.ProduitDAO;
import java.io.IOException;
import java.math.BigDecimal;
import java.util.HashMap;
import java.util.Map;

@WebServlet("/produits")
public class ProduitServlet extends HttpServlet {
    private ProduitDAO dao;

    @Override
    public void init() {
        dao = (ProduitDAO) getServletContext().getAttribute("produitDAO");
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        String action = req.getParameter("action");
        if (action == null) {
            req.setAttribute("produits", dao.findAll());
            req.getRequestDispatcher("/WEB-INF/views/produits/list.jsp").forward(req, resp);
        } else if ("new".equals(action)) {
            req.getRequestDispatcher("/WEB-INF/views/produits/form.jsp").forward(req, resp);
        } else if ("edit".equals(action)) {
            try {
                Long id = Long.parseLong(req.getParameter("id"));
                Produit p = dao.findById(id);
                if (p == null) {
                    resp.sendError(HttpServletResponse.SC_NOT_FOUND);
                } else {
                    req.setAttribute("produit", p);
                    req.getRequestDispatcher("/WEB-INF/views/produits/form.jsp").forward(req, resp);
                }
            } catch (NumberFormatException e) {
                resp.sendError(HttpServletResponse.SC_NOT_FOUND);
            }
        } else {
            resp.sendError(HttpServletResponse.SC_NOT_FOUND);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        String action = req.getParameter("action");

        if ("delete".equals(action)) {
            try {
                Long id = Long.parseLong(req.getParameter("id"));
                dao.delete(id);
                req.getSession().setAttribute("flash", "Produit supprimé avec succes.");
            } catch (NumberFormatException ignored) {}
            resp.sendRedirect(req.getContextPath() + "/produits");
            return;
        }

        String idStr = req.getParameter("id");
        String nom = req.getParameter("nom");
        String description = req.getParameter("description");
        String prixStr = req.getParameter("prix");
        String stockStr = req.getParameter("stock");

        Map<String, String> erreurs = new HashMap<>();

        if (nom == null || nom.trim().isEmpty()) {
            erreurs.put("nom", "Le nom est obligatoire.");
        } else if (nom.trim().length() < 2 || nom.trim().length() > 50) {
            erreurs.put("nom", "Le nom doit contenir entre 2 et 50 caracteres.");
        }

        BigDecimal prix = null;
        if (prixStr == null || prixStr.trim().isEmpty()) {
            erreurs.put("prix", "Le prix est obligatoire.");
        } else {
            try {
                prix = new BigDecimal(prixStr.trim());
                if (prix.compareTo(BigDecimal.ZERO) <= 0) {
                    erreurs.put("prix", "Le prix doit être strictement positif.");
                }
            } catch (NumberFormatException e) {
                erreurs.put("prix", "Format de prix invalide.");
            }
        }

        int stock = 0;
        if (stockStr != null && !stockStr.trim().isEmpty()) {
            try {
                stock = Integer.parseInt(stockStr.trim());
                if (stock < 0) {
                    erreurs.put("stock", "Le stock ne peut pas etre négatif.");
                }
            } catch (NumberFormatException e) {
                erreurs.put("stock", "Format de stock invalide.");
            }
        }

        if (description != null && description.length() > 255) {
            erreurs.put("description", "La description ne doit pas depasser 255 caractères.");
        }

        Long id = (idStr != null && !idStr.trim().isEmpty()) ? Long.parseLong(idStr.trim()) : null;
        Produit produit = new Produit(id, nom, description, prix, stock);

        if (!erreurs.isEmpty()) {
            req.setAttribute("erreurs", erreurs);
            req.setAttribute("produit", produit);
            req.getRequestDispatcher("/WEB-INF/views/produits/form.jsp").forward(req, resp);
        } else {
            dao.save(produit);
            req.getSession().setAttribute("flash", "Produit \"" + nom + "\" enregistre avec succes.");
            resp.sendRedirect(req.getContextPath() + "/produits");
        }
    }
}