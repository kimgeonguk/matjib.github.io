package board;

public class ActionForward {	// 포워딩(forwarding) 정보를 저장할 수 있는 클래스
	
	private String path;
	private boolean redirect;
	
	public ActionForward(String path, boolean redirect) {
	
		this.path = path;
		this.redirect = redirect;
	}

	public String getPath() {
		return path;
	}

	public void setPath(String path) {
		this.path = path;
	}

	public boolean isRedirect() {
		return redirect;
	}

	public void setRedirect(boolean redirect) {
		this.redirect = redirect;
	}
	
	
}
