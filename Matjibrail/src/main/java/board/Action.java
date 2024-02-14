package board;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import board.ActionForward;

public interface Action {			

	ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception;
}
