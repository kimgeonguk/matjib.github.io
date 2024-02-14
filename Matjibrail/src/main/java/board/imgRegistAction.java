package board;

import java.io.PrintWriter;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;			// 중복적용을 위한 import

public class imgRegistAction implements Action{
	
		@Override
		public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
			
			I_BoardVO vo = new I_BoardVO();
			
			String realFolder = "";			// 물리적인 경로
			
			String saveFolder = "http://localhost:9000/JspPractice/i_board/img/i_boardContent.jsp/";		// 실제로 파일이 저장되는 경로
			
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


