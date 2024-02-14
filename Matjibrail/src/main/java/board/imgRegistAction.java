package board;

import java.io.PrintWriter;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;			// �ߺ������� ���� import

public class imgRegistAction implements Action{
	
		@Override
		public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
			
			I_BoardVO vo = new I_BoardVO();
			
			String realFolder = "";			// �������� ���
			
			String saveFolder = "http://localhost:9000/JspPractice/i_board/img/i_boardContent.jsp/";		// ������ ������ ����Ǵ� ���
			
			String encType = "utf-8";
			
			int maxSize = 10 * 1024* 1024;
			
			ServletContext context = request.getServletContext();
			
			realFolder = context.getRealPath(saveFolder);
			
			MultipartRequest multi = new MultipartRequest(request, realFolder, maxSize, encType, new DefaultFileRenamePolicy());
			
			String image = multi.getFilesystemName("mi_image");
			
			ActionForward forward = null;
			
			return forward;
		}

	}


