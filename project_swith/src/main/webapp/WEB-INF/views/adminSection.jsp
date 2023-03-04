<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!-- MAIN -->
<div id="main">
  <!-- wrapper-main -->
  <div class="wrapper admin">
    <!-- ENDS filter -->
    <!-- Sidebar -->
    <div class="mySidebar admin">
      <!-- table -->
      <h6 class="mySidebar side-title admin"><span>Options</span></h6>
      <!-- ENDS table -->
      <!-- My Category -->
	   	<div class="mypage_mid_l admin">
	         <div class="mypage_mid_l_wrap">
	             <ul class="mypage_mid_l_ul">
	                 <li class="mypage_mid_l_ul_li"><a href="javascript:listChangeHandler('스터디 관리')" class="mypage_mid_l_ul_li_a">스터디 관리<img src="<%=request.getContextPath()%>/resources/images/my_arrow.png" alt=""></a></li>
	                 <li class="mypage_mid_l_ul_li"><a href="javascript:listChangeHandler('스터디 카페 등록')" class="mypage_mid_l_ul_li_a">스터디 카페 등록<img src="<%=request.getContextPath()%>/resources/images/my_arrow.png" alt=""></a></li>
	                 <li class="mypage_mid_l_ul_li"><a href="javascript:listChangeHandler('스터디 카페 관리')" class="mypage_mid_l_ul_li_a">스터디 카페 관리<img src="<%=request.getContextPath()%>/resources/images/my_arrow.png" alt=""></a></li>
	                 <li class="mypage_mid_l_ul_li"><a href="javascript:listChangeHandler('통계 조회')" class="mypage_mid_l_ul_li_a">통계 조회<img src="<%=request.getContextPath()%>/resources/images/my_arrow.png" alt=""></a></li>
	                 <li class="mypage_mid_l_ul_li"><a href="javascript:listChangeHandler('회원 관리')" class="mypage_mid_l_ul_li_a">회원 관리<img src="<%=request.getContextPath()%>/resources/images/my_arrow.png" alt=""></a></li>
	             </ul>
	         </div>
	     </div>
	   <!-- ENDS My Category -->
    </div>
    <!-- ENDS Sidebar -->
    <!--   -->
    <!-- MyStudyList -->
    <div class="right-wrapper admin">
    	<div class="right-content admin">
    		<div class="padding admin">
	    		<div class="title_wrap admin">
    				<h3 class="p-title admin" id="myStudyTitle">스터디 관리</h3>
    				<label class="form-label" id='admin_title_label'><span class="tip_mark admin coral">*</span>필수 입력 사항</label>
	    		</div>
    			<hr>
    		</div>
    		
    		<div class="admin_content_wrap show" id="admin_study_div">
    			<form class="study_serch_form" id="study_serch_form">
    				<div>
	    				<label>카테고리 : </label>
	    				<select name="study_category">
	    					<option value="0">전체</option>
		    				<c:forEach items="${scList}" var="sc">
		    					<option value="${sc.study_category_code}">${sc.study_category_name}</option>
		    				</c:forEach>
	    				</select>
    				</div>
    				<div>
	    				<label>진행상태 : </label>
	    				<select name="study_condition">
	    					<option value="0">전체</option>
	    					<option value="1">시작 예정</option>
	    					<option value="2">진행 중</option>
	    					<option value="3">종료</option>
	    				</select>
    				</div>
    				<div>
	    				<label>검색 : </label>
    					<input type="text" name="study_keyword" placeholder="키워드를 입력해주세요">
    				</div>
    				<button type="button" onclick="studyAdminSerchHandler(1);" class="btn btn-sm btn-secondary">조회</button>
    			</form>
   				<div>
   					<div class="admin_list" id="admin_list">
   						<div class='list_null'>
   							<h5>원하는 스터디 목록을 조회해주세요.</h5>
   						</div>
			        </div>
		            <ul class="pager" id="admin_page">
				    </ul>
   				</div>
	    	</div>
	    	
	    	<div class="admin_content_wrap" id="admin_studyCafeEnroll_div">
	    		<form id="admin_write_form" action="<%=request.getContextPath()%>/place/write" method="post" enctype="multipart/form-data">
	    		<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
		          <div class="mb-3">
		          	<div class="label_wrap admin">
		            	<label class="form-label" for="basic-default-fullname">스터디 카페 상호명</label>
			            <span class="tip_mark admin coral">*</span>
		            </div>
		            <input type="text" name="p_name" class="form-control" placeholder="스터디 카페 상호명을 입력해주세요.">
		          </div>
		          <div class="mb-3">
		          	<label class="form-label" for="basic-default-message">스터디 카페 소개</label>
		            <textarea class="form-control admin" name="p_info" placeholder="간단한 소개를 입력해주세요.(최대 120자까지 입력가능.)" maxlength="120"></textarea>
		            <span id="write_textarea_cnt" class="tip_mark admin">0</span><span class="tip_mark admin">/120자</span>
		          </div>
		          <div class="mb-3">
		          	<div class="label_wrap admin">
		            	<label class="form-label" for="basic-default-phone">전화번호</label>
			            <span class="tip_mark admin coral">*</span>
		            </div>
		            <input type="text" name="p_phone" class="form-control phone-mask" placeholder="0000-0000-0000">
		            <span id="writePlacePhone_text" class="tip_mark admin check"></span>
		          </div>
		          <div class="mb-3">
		          	<div class="label_wrap admin">
		            	<label class="form-label" for="basic-default-company">주소</label>
			            <span class="tip_mark admin coral">*</span>
		            </div>
		            <div class="address_wrap admin">
		            	<input type="text" name="post_code" class="form-control admin" id="adminPlaceWritePost" placeholder="우편 번호" readonly="readonly">
		            	<button class="btn address_search admin" type="button" onclick="writeSearchPostCode();">
                            <span>
                                <img src="<%=request.getContextPath()%>/resources/map/images/돋보기로고.jpg">
                                	주소검색
                            </span>
                        </button>
		            </div>
		          </div>
		          <div class="mb-3">
		            <input type="text" name="address_first" class="form-control admin" id="adminPlaceWriteAddr" placeholder="기본 주소" readonly="readonly">
		          </div>
		          <div class="mb-3">
		            <input type="text" name="address_second" class="form-control admin" placeholder="상세 주소">
		          </div>
		          <div class="mb-3">
		            <div class="label_wrap admin">
			            <label class="form-label" for="basic-default-email">대표 사진 등록</label>
			            <span class="tip_mark admin coral">*</span>
		            </div>
		            <input type="file" class="form-control" name="file"  accept="image/*">
		            <span class="tip_mark admin">*최대 1개 이미지 파일 등록 가능</span>
		          </div>
		          <button type="submit" class="btn btn-secondary">등록</button>
		        </form>
	    	</div>
<script type="text/javascript">
//스터디 카페 등록 시 결과 메시지
$(function(){
	var msg = '${msg}';
	if(msg != '') {
		alert(msg);
	}
});
/* 스터디 카페 등록 */
//우편 api
function writeSearchPostCode(){
    new daum.Postcode({
        oncomplete: function(data) {
            // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분입니다.
            // 예제를 참고하여 다양한 활용법을 확인해 보세요.
            var post_code = data.zonecode;
            var addr = data.roadAddress;
            
            document.getElementById('adminPlaceWritePost').value = post_code;
                     document.getElementById("adminPlaceWriteAddr").value = addr;
        }
    }).open();
}
//유효성 검사
//등록 시 체크
function adminWriteFromHandler() { 
	//스터디 카페 명 입력 체크
	var $placeName = $("#admin_write_form input[type=text][name=p_name]").val();
	if($placeName == "" || $placeName == null) {
		alert("상호명을 입력 해주세요.");
		return false;
	} 
	
	//전화번호 입력 체크
	var $placePhone = $("#admin_write_form input[type=text][name=p_phone]").val();
	
	var reg = /^[0-9]{3,4}-[0-9]{3,4}-[0-9]{4}$/;
	if($placePhone == "" || $placePhone == null) {
		alert("전화번호를 입력 해주세요.");
		return false;
	} else {
		if(!reg.test($placePhone)) {
			alert("전화번호가 형식에 맞지 않습니다.");
			return false;
		} 
	}
	
	//주소 확인
	var $placeAddressFirst = $("#admin_write_form input[type=text][name=address_first]").val();
	if($placeAddressFirst == "" || $placeAddressFirst == null) {
		alert("기본 주소를 선택 해주세요.");
		return false;
	} 
	
	var $placeAddressSecond = $("#admin_write_form input[type=text][name=address_second]").val();
	if($placeAddressSecond == "" || $placeAddressSecond == null) {
		alert("상세 주소를 입력 해주세요.");
		return false;
	} 
	
	//대표 사진 체크
	var $placeFile = $("#admin_write_form input[type=file][name=file]").val();
    if(!$placeFile){
        alert("대표 사진을 첨부해 주세요");
        return false;
    }
}
$("#admin_write_form").submit(adminWriteFromHandler);
//휴대폰 형식 문구안내
function placeWritePhoneCheckBluredHandler() {
	var $placePhone = $("#admin_write_form input[type=text][name=p_phone]").val();
	
	var reg = /^[0-9]{3,4}-[0-9]{3,4}-[0-9]{4}$/;
	if(reg.test($placePhone) || $placePhone == "") {
		$("#writePlacePhone_text").text("");
	} else {
		$("#writePlacePhone_text").text("*전화번호 번호가 형식에 맞지 않습니다.");
	}
}
$("#admin_write_form input[type=text][name=p_phone]").on("propertychange change paste input",placeWriteInfoCountHandler);
//소개 글자수 체크
function placeWriteInfoCountHandler() {
	var $textarea = $("#admin_write_form textarea").val();
	
	// 글자수 세기
    if ($textarea.length == 0 || $textarea == '') {
    	$('#write_textarea_cnt').text('0');
    } else {
    	$('#write_textarea_cnt').text($textarea.length);
    }
}
$("#admin_write_form textarea").on("propertychange change paste input",placeWriteInfoCountHandler);
</script>
	    	<div class="admin_content_wrap" id="admin_studyCafe_div">
	    		<form class="study_serch_form" id="studyCafe_serch_form">
	    			<div>
	    				<label>시도 : </label>
	    				<select name="sido_name" id="sido">
	    					<option value="선택">선택</option>
	    					<c:forEach items="${sidoList}" var="sido">
	                   			<c:choose>
	                   				<c:when test="${sido ne '세종특별자치시'}">
	                   					<option value="${sido}">${sido}</option>
	                   				</c:when>
	                   				<c:otherwise>
	                   					<option value="${sido}">세종</option>
	                   				</c:otherwise>
	                   			</c:choose>
		    				</c:forEach>
	    				</select>
	    			</div>
	    			<div>
	    				<label>시군구 : </label>
	    				<select name="area_code" id="area_code">
	                		<option value="0"> - </option>
	    				</select>
	    			</div>
	    			<div>
	    				<label>검색 : </label>
	    				<input type="text" name="studyCafe_keyword" placeholder="키워드를 입력해주세요">
	    			</div>
    				<button type="button" onclick="studyCafeAdminSerchHandler(1);" class="btn btn-sm btn-secondary">조회</button>
    			</form>
   				<div>
   					<div class="admin_list" id="admin_cafe_list">
   						<div class='list_null'>
   							<h5>원하는 스터디카페 목록을 조회해주세요.</h5>
   						</div>
			        </div>
		            <ul class="pager" id="admin_cafe_page">
				    </ul>
   				</div>
	    	</div>
	    	<div class="admin_content_wrap" id="admin_reserve_div">
	    		<form class="study_serch_form" id="reserve_serch_form">
	    			<div>
	    				<label>시도 : </label>
	    				<select name="sido_name" id="reserve_sido">
	    					<option value="선택">선택</option>
	                   		<option value="전체">전체</option>
	                   		<c:forEach items="${sidoList}" var="sido">
	                   			<c:choose>
	                   				<c:when test="${sido ne '세종특별자치시'}">
	                   					<option value="${sido}">${sido}</option>
	                   				</c:when>
	                   				<c:otherwise>
	                   					<option value="${sido}">세종</option>
	                   				</c:otherwise>
	                   			</c:choose>
		    				</c:forEach>
	    				</select>
	    			</div>
	    			<div>
	    				<label>시군구 : </label>
	    				<select name="area_code" id="reserve_area_code">
	                		<option value="0"> - </option>
	    				</select>
	    			</div>
    				<button type="button" onclick="reserveAdminSerchAjax();" class="btn btn-sm btn-secondary">조회</button>
    			</form>
	    		<div class="chart_wrap">
	    			<div id="firstChart_title"><div class='list_null'><h5>원하는 지역을 조회해주세요.</h5></div></div>
					<div id="firstChart_div"><canvas id="firstChart" ></canvas></div>
	    			<div id="secondChart_title"></div>
					<div id="secondChart_div"><canvas id="secondChart" ></canvas><div id='legend_div' class="legend_div"></div></div>
	    		</div>
	    	</div>
	    	<div class="admin_content_wrap" id="admin_member_div">
	    	</div>
	    	
	   </div>
    </div>
    <!-- End MyStudyList -->
    <div class="clear"></div>
  </div>
  <!-- ENDS wrapper-main -->
</div>
<div class="modal studyCafe">
	<div class="modal_content_wrap studyCafe">
		<div class="modal_content studyCafe">
			<form id="amdin_update_form">
	    		<input type="hidden" name="p_no"/>
	          	<div class="mb-3">
	          		<div class="label_wrap admin">
	            		<label class="form-label" for="basic-default-fullname">스터디 카페 이름</label>
	            	</div>
	            	<input type="text" name="p_name" class="form-control" placeholder="스터디 카페 상호명을 입력해주세요.">
	          	</div>
	          	<div class="mb-3">
	          		<label class="form-label" for="basic-default-message">스터디 카페 소개</label>
	            	<textarea class="form-control admin" name="p_info" placeholder="간단한 소개를 입력해주세요."></textarea>
	          	</div>
	          	<div class="mb-3">
	          		<div class="label_wrap admin">
	            		<label class="form-label" for="basic-default-phone">전화번호</label>
	            </div>
	            <input type="text" name="p_phone" class="form-control phone-mask" placeholder="000-0000-0000">
	          	</div>
	          	<div class="mb-3">
	          		<div class="label_wrap admin">
	            		<label class="form-label" for="basic-default-company">주소</label>
	            	</div>
            		<div class="address_wrap admin">
		            	<input type="text" name="post_code" class="form-control admin" id="adminPlaceUpdatePost" placeholder="우편 번호" readonly="readonly">
		            	<button class="btn address_search admin update" type="button" onclick="updateSearchPostCode();">
	                    	<span>
	                            <img src="<%=request.getContextPath()%>/resources/map/images/돋보기로고.jpg">
	                             	주소검색
	                        </span>
	                    </button>
	            	</div>
	          	</div>
	         	<div class="mb-3">
	            	<input type="text" name="address_first" class="form-control admin" id="adminPlaceUpdateAddr" placeholder="기본 주소" readonly="readonly">
	          	</div>
	          	<div class="mb-3">
	            	<input type="text" name="address_second" class="form-control admin" placeholder="상세 주소">
	          	</div>
	          	<div class="mb-3">
	            	<div class="label_wrap admin">
		            	<label class="form-label" for="basic-default-email">대표 사진 등록</label>
	            	</div>
	            	<input type="file" class="form-control" name="file"  accept="image/*">
	          	</div>
	          	<div class="btn_wrap">
					<button class="btn btn-sm btn-info" type="button" id="amdin_update_form_btn">수정</button>
					<button class="btn btn-sm btn-secondary" type="button" id="amdin_update_modal_close">닫기</button>
				</div>
	        </form>
		</div>
	</div>
</div>
<script>
//네비 
function listChangeHandler(title) {
	//타이틀 수정
	$("#myStudyTitle").text(title);
	//전체 화면 숨기기
	$(".admin_content_wrap").removeClass("show");
	$("#admin_title_label").hide();
	
	switch(title) {
	case '스터디 관리' :
		//기존 입력된 값 초기화
		$("#study_serch_form select > option:first-of-type").prop("selected", true);
		$("#study_serch_form input[type=text][name=study_keyword]").val("");
		$("#admin_list").html("<div class='list_null'><h5>원하는 스터디 목록을 조회해주세요.</h5></div>");
		$("#admin_page").html("");
		//화면 바꾸기
		$("#admin_study_div").addClass("show"); break;
	case '스터디 카페 등록' : 
		//기존 입력된 값 초기화
		$("#admin_write_form input[type=text]").val("");
		$("#admin_write_form input[type=file]").val("");
		$("#admin_write_form textarea").val("");
		//화면 바꾸기
		$("#admin_studyCafeEnroll_div").addClass("show"); $("#admin_title_label").show(); break;
	case '스터디 카페 관리' : 
		//기존 입력된 값 초기화
		$("#studyCafe_serch_form select#sido > option:first-of-type").prop("selected", true);
		$("#studyCafe_serch_form select#area_code").html("<option value='0'> - </option>");
		$("#studyCafe_serch_form input[type=text][name=studyCafe_keyword]").val("");
		$("#admin_cafe_list").html("<div class='list_null'><h5>원하는 스터디 카페 목록을 조회해주세요.</h5></div>");
		$("#admin_cafe_page").html("");
		//화면 바꾸기
		$("#admin_studyCafe_div").addClass("show"); break;
	case '통계 조회' : 
		//기존 입력된 값 초기화
		$("#reserve_serch_form select#reserve_sido > option:first-of-type").prop("selected", true);
		$("#reserve_serch_form select#reserve_area_code").html("<option value='0'> - </option>");
		$('#firstChart').remove();
		$('#secondChart').remove();
		$("#firstChart_title").html("<div class='list_null'><h5>원하는 지역을 조회해주세요.</h5></div>");
		$("#secondChart_title").html("");
		//화면 바꾸기
		$("#admin_reserve_div").addClass("show"); break;
	case '회원 관리' : 
		$("#admin_member_div").addClass("show"); break;
	}
}
/* 스터디 관리 */
var studySerchForm = "";
function studyAdminPageHandler(num) {
	studyAdminSerchAjax(num);
}
function studyAdminSerchHandler(num) {
	studySerchForm = $("#study_serch_form").serialize();
	studyAdminSerchAjax(num);
}
function studyAdminSerchAjax(num) {
	var token = $("meta[name='_csrf']").attr("content");
	var header = $("meta[name='_csrf_header']").attr("content");
	var $adminList = $("#admin_list");
	var $adminPage = $("#admin_page");
	$.ajax({
		url : "<%=request.getContextPath()%>/admin/studyList.lo"
		, type : "post"
		, data : studySerchForm+"&page="+num
		, dataType : "json"
		, beforeSend : function(xhr) {
			xhr.setRequestHeader(header, token);
		}
		, success : function(result) {
			console.log(result.list);
			console.log(result.currentPage);
			console.log(result.maxPage);
			console.log(result.startPage);
			console.log(result.endPage);
			let addAdminList = "";
			if(result.list.length != 0) {
				for(var i = 0; i < result.list.length; i++) {
					addAdminList +=	"<div class='list_content study'>"+
						        		"<h5>"+result.list[i].study_name+"</h5>"+
						        		"<div>"+
						        			"<p>모임장 아이디 : "+result.list[i].nick_name+"</p>"+
						        			"<div>"+
						        				"<p>생성일 : "+result.list[i].study_create_date+"</p>"+
						        				"<p>시작일 : "+result.list[i].study_start_date+"</p>"+
						        				"<p>종료일 : "+result.list[i].study_end_date+"</p>"+
						        			"</div>"+
						        		"</div>"+
						        	"</div>";
				}
				$adminList.html(addAdminList);
			} else {
				addAdminList += "<div class='list_null'><h5>해당 조건의 스터디 목록이 없습니다.</h5></div>";
				$adminList.html(addAdminList);
			}
			
			let addpage = "";
			if(result.maxPage != 0 && result.maxPage != 1) {
				if(result.startPage != 1) {
					addpage += "<li class='first-page'><a href='javascript:studyAdminPageHandler(1);'>«</a></li>"+
							   "<li><a href='javascript:studyAdminPageHandler("+(result.startPage-1)+");'>‹</a></li>";
				}
				for(var i = result.startPage; i <= result.endPage; i++) {
					if(i == result.currentPage) {
						addpage += "<li class='active'><a href='javascript:studyAdminPageHandler("+i+");'>"+i+"</a></li>";
					} else {
						addpage += "<li><a href='javascript:studyAdminPageHandler("+i+");'>"+i+"</a></li>";
					}
				}
				if(result.endPage < result.maxPage) {
					addpage += "<li><a href='javascript:studyAdminPageHandler("+(result.endPage+1)+");'>›</a></li>"+
								"<li class='first-page'><a href='javascript:studyAdminPageHandler("+result.maxPage+");'>»</a></li>";
		   			
				}
			}
			$adminPage.html(addpage);
		}
		, error : function(request, status, errordata) {
			alert("error code:" + request.status + "/n"
					+ "message :" + request.responseText + "\n"
					+ "error :" + errordata + "\n");
		}
	});
}

/* 스터디 카페 관리 */
$("select#sido").on("change", function () {
	var token = $("meta[name='_csrf']").attr("content");
	var header = $("meta[name='_csrf_header']").attr("content");
	var $areaCode = $("select#area_code");
	$.ajax({
		url : "<%=request.getContextPath()%>/sigungu.lo"
		, type : "post"
		, data : { sido_name : $(this).val() }
		, dataType : "json"
		, beforeSend : function(xhr) {
			xhr.setRequestHeader(header, token);
		}
		, success : function(result) {
			if(result != null) {
				let addAreaCode = "<option value='99'>전체</option>";
				console.log(result.length);
				for(var i = 0; i < result.length; i++) {
					addAreaCode += "<option value='"+result[i].area_code+"'>"+result[i].sigungu_name+"</option>";
				}
				$areaCode.html(addAreaCode);
			} else {
				$areaCode.html("<option value='0'> - </option>");
			}
		}
		, error : function(request, status, errordata) {
			alert("error code:" + request.status + "/n"
					+ "message :" + request.responseText + "\n"
					+ "error :" + errordata + "\n");
		}
	});
});
//스터디 카페 관리 - 정보 수정
//기존 정보 가져오기
function adminCafeDataAjax(num) {
	var token = $("meta[name='_csrf']").attr("content");
	var header = $("meta[name='_csrf_header']").attr("content");
	
	$.ajax({
		url : "<%=request.getContextPath()%>/place/updateData.lo"
		, type : "post"
		, data : { p_no : num }
		, dataType : "json"
		, beforeSend : function(xhr) {
			xhr.setRequestHeader(header, token);
		}
		, success : function(result) {
			$("#amdin_update_form input[type=hidden][name=p_no]").val(result.p_no);
			$("#amdin_update_form input[type=text][name=p_name]").attr("placeholder", result.p_name);
			$("#amdin_update_form textarea[name=p_info]").attr("placeholder", result.p_info);
			$("#amdin_update_form input[type=text][name=p_phone]").attr("placeholder", result.p_phone);
		}
		, error : function(request, status, errordata) {
			alert("error code:" + request.status + "/n"
					+ "message :" + request.responseText + "\n"
					+ "error :" + errordata + "\n");
		}
	});
	
	$(".modal.studyCafe").show();
}
//정보 수정 모달창 닫기
$("#amdin_update_modal_close").on('click',function penaltyModalHideHandler() {
	$(".modal.studyCafe").hide();
});
//정보 수정 시 우편 api
function updateSearchPostCode(){
    new daum.Postcode({
        oncomplete: function(data) {
            // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분입니다.
            // 예제를 참고하여 다양한 활용법을 확인해 보세요.
            var post_code = data.zonecode;
            var addr = data.roadAddress;
            
            document.getElementById('adminPlaceUpdatePost').value = post_code;
                     document.getElementById("adminPlaceUpdateAddr").value = addr;
        }
    }).open();
}
//정보 수정
function adminCafeUpdateAjax() {
	var token = $("meta[name='_csrf']").attr("content");
	var header = $("meta[name='_csrf_header']").attr("content");
	var $amdinUpdateForm = $("#amdin_update_form").serialize();
	
	$.ajax({
		url : "<%=request.getContextPath()%>/place/update.lo"
		, type : "post"
		, data : $amdinUpdateForm
		, beforeSend : function(xhr) {
			xhr.setRequestHeader(header, token);
		}
		, success : function(result) {
			if(result > 0) {
				alert("스터디 카페 정보 수정에 성공하였습니다.");
			} else {
				alert("스터디 카페 정보 수정에 시도하였으나 실패하였습니다.");
			}
		}
		, error : function(request, status, errordata) {
			alert("error code:" + request.status + "/n"
					+ "message :" + request.responseText + "\n"
					+ "error :" + errordata + "\n");
		}
	});
}
$("#amdin_update_form_btn").on('click', adminCafeUpdateAjax);
//스터디 카페 관리 - 룸 등록
function adminRoomWriteAjax(num) {
	
}
//스터디 카페 관리 - 룸 관리
function adminRoomDataAjax(num) {
	
}
//스터디 카페 관리 - 삭제
function adminCafeDeleteAjax(num) {
	
}

var studyCafeSerchFormData = "";
//스터디 카페 관리 - 조회
function studyAdminCafePageHandler(num) {
	studyCafeAdminSerchAjax(num);
}
function studyCafeAdminSerchHandler(num) {
	studyCafeSerchFormData = $("#studyCafe_serch_form").serialize();
	studyCafeAdminSerchAjax(num);
}
function studyCafeAdminSerchAjax(num) {
	var token = $("meta[name='_csrf']").attr("content");
	var header = $("meta[name='_csrf_header']").attr("content");
	var $adminCafeList = $("#admin_cafe_list");
	var $adminCafePage = $("#admin_cafe_page");
	
	console.log("studyCafeSerchFormData : " + studyCafeSerchFormData);
	$.ajax({
		url : "<%=request.getContextPath()%>/admin/studyCafeList.lo"
		, type : "post"
		, data : studyCafeSerchFormData+"&page="+num
		, dataType : "json"
		, beforeSend : function(xhr) {
			xhr.setRequestHeader(header, token);
		}
		, success : function(result) {
			if(!result.check) {
				alert("지역선택이 올바르지 않습니다.");
				return;
			}
			let addAdminCafeList = "";
			if(result.list.length != 0) {
				for(var i = 0; i < result.list.length; i++) {
					addAdminCafeList +=	"<div class='list_content studyCafe'>"+
											"<div class='item'>"+
												"<img class='img' src='"+result.list[i].p_img_route +"'>"+
												"<div class='info'>"+
													"<h5>"+result.list[i].p_name+"</h5>"+
													"<span class='gray'>주소 : "+result.list[i].p_address+"</span>"+
													"<span class='tel'>전화번호 : "+result.list[i].p_phone+"</span>"+
												"</div>"+
											"</div>"+
							        		"<div class='list_right_content'>"+
								        		"<div class='btn-group'>"+
										          	"<button type='button' class='btn btn-primary btn-icon rounded-pill dropdown-toggle hide-arrow' data-bs-toggle='dropdown' aria-expanded='false'><i class='bx bx-dots-vertical-rounded'></i></button>"+
										          	"<ul class='dropdown-menu dropdown-menu-end' style=''>"+
										            	"<li><a class='dropdown-item' href='javascript:adminCafeDataAjax("+result.list[i].p_no+");'>정보 수정</a></li>"+
										            	"<li><hr class='dropdown-divider'></li>"+
										            	"<li><a class='dropdown-item' href='javascript:adminRoomWriteAjax("+result.list[i].p_no+");'>스터디 룸 등록</a></li>"+
										            	"<li><hr class='dropdown-divider'></li>"+
										            	"<li><a class='dropdown-item' href='javascript:adminRoomDataAjax("+result.list[i].p_no+");'>스터디 룸 관리</a></li>"+
										            	"<li><hr class='dropdown-divider'></li>"+
										            	"<li><a class='dropdown-item' href='javascript:adminCafeDeleteAjax("+result.list[i].p_no+");'>삭제</a></li>"+
										          	"</ul>"+
											    "</div>"+
							        		"</div>"+
						        		"</div>";
				}
				$adminCafeList.html(addAdminCafeList);
			} else {
				addAdminCafeList += "<div class='list_null'><h5>해당 조건의 스터디카페 목록이 없습니다.</h5></div>";
				$adminCafeList.html(addAdminCafeList);
			}
			
			let addCAfePage = "";
			if(result.maxPage != 0 && result.maxPage != 1) {
				if(result.startPage != 1) {
					addCAfePage += "<li class='first-page'><a href='javascript:studyAdminCafePageHandler(1);'>«</a></li>"+
							   "<li><a href='javascript:studyAdminCafePageHandler("+(result.startPage-1)+");'>‹</a></li>";
				}
				for(var i = result.startPage; i <= result.endPage; i++) {
					if(i == result.currentPage) {
						addCAfePage += "<li class='active'><a href='javascript:studyAdminCafePageHandler("+i+");'>"+i+"</a></li>";
					} else {
						addCAfePage += "<li><a href='javascript:studyAdminCafePageHandler("+i+");'>"+i+"</a></li>";
					}
				}
				if(result.endPage < result.maxPage) {
					addCAfePage += "<li><a href='javascript:studyAdminCafePageHandler("+(result.endPage+1)+");'>›</a></li>"+
									"<li class='first-page'><a href='javascript:studyAdminCafePageHandler("+result.maxPage+");'>»</a></li>";
				}
			}
			$adminCafePage.html(addCAfePage);
		}
		, error : function(request, status, errordata) {
			alert("error code:" + request.status + "/n"
					+ "message :" + request.responseText + "\n"
					+ "error :" + errordata + "\n");
		}
	});
}

/* 예약 통계 */
 $("select#reserve_sido").on("change", function () {
	var token = $("meta[name='_csrf']").attr("content");
	var header = $("meta[name='_csrf_header']").attr("content");
	var $areaCode = $("select#reserve_area_code");
	$.ajax({
		url : "<%=request.getContextPath()%>/sigungu.lo"
		, type : "post"
		, data : { sido_name : $(this).val() }
		, dataType : "json"
		, beforeSend : function(xhr) {
			xhr.setRequestHeader(header, token);
		}
		, success : function(result) {
			if(result != null) {
				let addAreaCode = "<option value='99'>전체</option>";
				console.log(result.length);
				for(var i = 0; i < result.length; i++) {
					addAreaCode += "<option value='"+result[i].area_code+"'>"+result[i].sigungu_name+"</option>";
				}
				$areaCode.html(addAreaCode);
			} else {
				$areaCode.html("<option value='0'> - </option>");
			}
		}
		, error : function(request, status, errordata) {
			alert("error code:" + request.status + "/n"
					+ "message :" + request.responseText + "\n"
					+ "error :" + errordata + "\n");
		}
	});
});
function reserveAdminSerchAjax() {
	var token = $("meta[name='_csrf']").attr("content");
	var header = $("meta[name='_csrf_header']").attr("content");
	
	if($("select#reserve_code").val() == 0 || $("select#reserve_sido").val() == "선택") {
		alert("지역선택이 올바르지 않습니다.");
		return;
	}
	
	$.ajax({
		url : "<%=request.getContextPath()%>/rezadmin.lo"
		, type : "post"
		, data : $("#reserve_serch_form").serialize()
		, dataType : "json"
		, beforeSend : function(xhr) {
			xhr.setRequestHeader(header, token);
		}
		, success : function(result) {
			
			//기존 차트 제거
			$('#firstChart').remove();
			$('#secondChart').remove();
			
			//차트 태그 다시 추가 및 타이틀 태그 변경
			$('#firstChart_div').append('<canvas id="firstChart" ></canvas>');
			$('#secondChart_div').append('<canvas id="secondChart" ></canvas>');
			$("#firstChart_title").html('<h6>월별 매출</h6>');
			$("#secondChart_title").html('<h6>월별 건수</h6>');
			
			
			var Label1 = [];
			var Data1 = [];
			var Label2 = [];
			var Data2 = [];
			
			for(var i = 0; i < result.PriceList.length; i++) {
				Label1.push(result.PriceList[i].chart_date);
				Data1.push(result.PriceList[i].chart_price);
			}
			for(var i = 0; i < result.CntList.length; i++) {
				Label2.push(result.CntList[i].chart_date);
				Data2.push(result.CntList[i].chart_cnt);
			}
			
			var firstData = {
					   labels: Label1,
					   datasets: [{
					     data: Data1,
					     backgroundColor: [
					         'rgba(255, 99, 132, 0.5)',
					         'rgba(255, 159, 64, 0.5)',
					         'rgba(255, 205, 86, 0.5)',
					         'rgba(75, 192, 192, 0.5)',
					         'rgba(54, 162, 235, 0.5)',
					         'rgba(153, 102, 255, 0.5)'
					         ],
					     borderColor: [
					         'rgb(255, 99, 132)',
					         'rgb(255, 159, 64)',
					         'rgb(255, 205, 86)',
					         'rgb(75, 192, 192)',
					         'rgb(54, 162, 235)',
					         'rgb(153, 102, 255)'
					       ],
					     borderWidth: 1
					   }]};
			
			var secondData = {
					   labels: Label2,
					   datasets: [{
					     data: Data2,
					     backgroundColor: [
					         'rgba(255, 99, 132, 0.5)',
					         'rgba(255, 159, 64, 0.5)',
					         'rgba(255, 205, 86, 0.5)',
					         'rgba(75, 192, 192, 0.5)',
					         'rgba(54, 162, 235, 0.5)',
					         'rgba(153, 102, 255, 0.5)'
					         ],
					     borderColor: [
					         'rgb(255, 99, 132)',
					         'rgb(255, 159, 64)',
					         'rgb(255, 205, 86)',
					         'rgb(75, 192, 192)',
					         'rgb(54, 162, 235)',
					         'rgb(153, 102, 255)'
					       ],
					     borderWidth: 1
					   }]};
			   
			   var firstOptions = {
			      	/* title : {
						display : true,
						text: '월별 매출'
					}, */
					scales: {
				      	yAxes: [{
				        	ticks : {
				        		/* min: 0,
								max: 1000000, */
				        		beginAtZero: true //0부터 표시
				        	}
				      	}]
				    },
				    legend: {
				    	display : false // 상단 색상별 라벨 제거
				    },
				    tooltips : {
				    	callbacks: {
				    		label : function(tooltipItem) { // 툴팁 정보 수정
				    			return tooltipItem.yLabel+"원"; //수치 + 원
				    		}
				    	}
				    }
			   };
			   var secondOptions = {
				      	/* title : {
							display : true,
							text: '월별 건수'
						}, */
						scales: {
					      	yAxes: [{
					        	ticks : {
					        		/* min: 0,
									max: 100, */
					        		beginAtZero: true //0부터 표시
					        	}
					      	}]
					    },
					    legend: {
					    	display : false // 상단 색상별 라벨 제거
					    },
					    tooltips : {
					    	callbacks: {
					    		label : function(tooltipItem) { // 툴팁 정보 수정
					    			return tooltipItem.yLabel+"건"; //수치 + 원
					    		}
					    	}
					    }
				   };
			   
			   var firstChart = new Chart($('#firstChart').get(0).getContext('2d'), {
			       type: 'bar', // 차트의 형태
			       data: firstData,
			       options: firstOptions
			   });
			   
			   var secondChart = new Chart($('#secondChart').get(0).getContext('2d'), {
			       type: 'bar', // 차트의 형태
			       data: secondData,
			       options: secondOptions
			   });
		}
		, error : function(request, status, errordata) {
			alert("error code:" + request.status + "/n"
					+ "message :" + request.responseText + "\n"
					+ "error :" + errordata + "\n");
		}
	});	
}
   
   /* var secondData = {
		    labels: ['2022-10', '2022-11', '2022-12', '2023-01', '2023-02', '2023-03'],
		    datasets: [{
		        data: [1, 12, 13, 7, 13, 10],
		        backgroundColor: [
			         'rgba(255, 99, 132, 0.5)',
			         'rgba(255, 159, 64, 0.5)',
			         'rgba(255, 205, 86, 0.5)',
			         'rgba(75, 192, 192, 0.5)',
			         'rgba(54, 162, 235, 0.5)',
			         'rgba(153, 102, 255, 0.5)',
			         'rgba(201, 203, 207, 0.5)'
			         ]
		    }] 
		};
   
   let customLegend = function (chart) {
	    let ul = document.createElement('ul');
	    let color = chart.data.datasets[0].backgroundColor;

	    chart.data.labels.forEach(function (label, index) {
	        ul.innerHTML += '<li><span style="background-color:'+color[index]+'"></span>'+label+'</li>';
	    });

	    return ul.outerHTML;
	};
	
   var secondOption = {
		   responsive: false,
		    title : {
				display : true,
				text: '예약 통계'
			}, 
		    legend: {
		    	display : false // 상단 색상별 라벨 제거
		    },
		    legendCallback: customLegend
   		}
	
   window.secondChart = new Chart(secondContent, {
        type: 'pie',
        data: secondData,
        options: secondOption
    });
   
   document.getElementById('legend_div').innerHTML = window.secondChart.generateLegend(); */
</script>
<!-- ENDS MAIN -->