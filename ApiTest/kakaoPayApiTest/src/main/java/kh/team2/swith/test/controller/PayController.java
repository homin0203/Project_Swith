package kh.team2.swith.test.controller;

import java.io.BufferedReader;
import java.io.DataOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
@RequestMapping("/paytest")
public class PayController {
	
	@RequestMapping("/kakaopay.cls")
	@ResponseBody
	public String kakaopay() {
		try {
			//kakao pay server 연결
			URL url = new URL("https://kapi.kakao.com/v1/payment/ready");
			HttpURLConnection  conn = (HttpURLConnection) url.openConnection();
			conn.setRequestMethod("POST");
			conn.setRequestProperty("Authorization", "KakaoAK b515bd58d75d5c8d3bd6e376d06b22e6");
			conn.setRequestProperty("Content-type", "application/x-www-form-urlencoded;charset=utf-8");
			conn.setDoOutput(true); //input은 default값 true
			//전달할 파라미터 세팅
			String param = "cid=TC0ONETIME"
					+ "&partner_order_id=partner_order_id" // 가맹점 주문번호
					+ "&partner_user_id=partner_user_id" // 가맹점 회원 id
					+ "&item_name=초코파이" // 상품명
					+ "&quantity=1" // 상품 수량
					+ "&total_amount=5000" // 총 금액
					+ "&vat_amount=200" // 부가세
					+ "&tax_free_amount=0" // 상품 비과세 금액
					+ "&approval_url=http://localhost:8090/" // 결제 성공 시 //이하 url 3개는 등록한 도메인만 사용
					+ "&fail_url=http://localhost:8090/" // 결제 실패 시
					+ "&cancel_url=http://localhost:8090/"; // 결제 취소 시

			//세팅한 파라미터 전달
			OutputStream out = conn.getOutputStream();
			DataOutputStream data = new DataOutputStream(out); //데이터 전달 역할
			data.writeBytes(param); //input, output stream은 byte형식으로 데이터 전달하게됨
			
			//close하면 자동으로 flush
			data.close(); //파라미터 밀어넣기
			
			//파라미터 전달후 성공 여부
			int result = conn.getResponseCode();
			
			// 결과 전달
			InputStream in;
			if(result == 200) // 통신성공
				in = conn.getInputStream();
			else // 통신 실패
				in = conn.getErrorStream();
			
			//결과 읽기
			InputStreamReader read = new InputStreamReader(in);
			
			//byte -> 변환, bufferedreader에는 형변환 기능 있음
			BufferedReader buff = new BufferedReader(read);
			return buff.readLine();
		} catch (MalformedURLException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
		return "{\"result\":\"NO\"}";
	}
	
	@GetMapping("/kakaopay")
	public String kakaopayMain() {
		return "/test/kakaopay";
	}
}
