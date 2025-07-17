import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/data")
public class DataServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String date = request.getParameter("date");
        String amount = request.getParameter("amount");
        String remark = request.getParameter("remark");
        String comment = request.getParameter("comment");

        System.out.println("Received Data:");
        System.out.println("Date: " + date);
        System.out.println("Amount: " + amount);
        System.out.println("Remark: " + remark);
        System.out.println("Comment: " + comment);

        // Set attributes to display on the JSP page
        request.setAttribute("submittedDate", date);
        request.setAttribute("submittedAmount", amount);
        request.setAttribute("submittedRemark", remark);
        request.setAttribute("submittedComment", comment);

        // Forward back to the JSP page to display the submitted data
        request.getRequestDispatcher("index.jsp").forward(request, response);
    }
}