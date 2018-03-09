<%@page import="com.cafe24.ourplanners.member.dto.LoginDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%
	response.setHeader("Cache-Control", "no-store");
	response.setHeader("Pragma", "no-cache");
	response.setDateHeader("Expires", 0);
	if (request.getProtocol().equals("HTTP/1.1"))
		response.setHeader("Cache-Control", "no-cache");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta name="description" content="">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>|OUR PLANNERS</title>
<jsp:useBean id="today" class="java.util.Date" scope="page" />
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.1/css/bootstrap.min.css?ver=<fmt:formatDate value="${today}" pattern="yyyyMMddHHmmss" />">
<link rel='stylesheet' href='http://fonts.googleapis.com/css?family=Open+Sans:300,400,400italic,600,700|Raleway:300,400,500,600'>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.2.0/css/font-awesome.min.css?ver=<fmt:formatDate value="${today}" pattern="yyyyMMddHHmmss" />">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/style.css?ver=<fmt:formatDate value="${today}" pattern="yyyyMMddHHmmss" />">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/commonTop_1.css?ver=<fmt:formatDate value="${today}" pattern="yyyyMMddHHmmss" />">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/commonTop_2.css?ver=<fmt:formatDate value="${today}" pattern="yyyyMMddHHmmss" />">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/commonBottom.css?ver=<fmt:formatDate value="${today}" pattern="yyyyMMddHHmmss" />">

<link rel="shortcut icon" href="${pageContext.request.contextPath}/resources/images/icons/favicon.ico">


<!-- HTML5 shim and Respond.js IE8 support of HTML5 elements and media queries -->
<!--[if lt IE 9]>
      <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
      <script src="https://oss.maxcdn.com/libs/respond.js/1.3.0/respond.min.js"></script>
    <![endif]-->



<script src="http://ajax.googleapis.com/ajax/libs/jquery/2.1.1/jquery.min.js?ver=<fmt:formatDate value="${today}" pattern="yyyyMMddHHmmss" />"></script>

<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.1/js/bootstrap.min.js?ver=<fmt:formatDate value="${today}" pattern="yyyyMMddHHmmss" />"></script>

<script type="text/javascript" charset="utf-8">
	sessionStorage.setItem("contextpath", "${pageContext.request.contextPath}");
</script>

<script>
function servicePaging(nowPage, category_srl, subcategory_srl , board_type,searchType,keyword) {
	var params = "board_type="+board_type+"&pageSize=6&blockPage=5&keyword="+keyword+"&searchType="+searchType;
	alert(params);
	getServiceSearchList(nowPage, category_srl, subcategory_srl , board_type);
}

function getServiceSearchList(nowPage, category_srl, subcategory_srl , board_type ,searchType,keyword) {
	nowPage = typeof nowPage !== 'undefined' ? nowPage : 1;
	
	board_type = typeof board_type !== 'undefined' ? board_type : "";
	
	category_srl = typeof category_srl !== 'undefined' ? category_srl : "";
	subcategory_srl = typeof subcategory_srl !== 'undefined' ? subcategory_srl : "";
	
	searchType = typeof searchType !== 'undefined' ? searchType : "";
	
	keyword = typeof keyword !== 'undefined' ? keyword : "";
	
	if(category_srl==0)
	{
		category_srl="";
	}
	if(subcategory_srl==0){
		subcategory_srl="";
	}
	
	var url = "${pageContext.request.contextPath}/board/json/service_list.json";
	var serviceMainImgPath = "${pageContext.request.contextPath}/resources/upload/service/";
	//내용 지우기
	$("#search_list_div").empty();
	var params = "board_type="+board_type+"&pageSize=6&blockPage=5&keyword="+keyword+"&searchType="+searchType;
	//alert(params);
	$.ajax({
		cache : false, // 캐시 사용 없애기
		type : 'post',
		url : url,
		data : params,
		//data : JSON.stringify({ board_type: 'E', pageSize: '3', blockPage: '1'}),
		//contentType: 'application/json; charset=utf-8',
		dataType : 'json',
		//contentType: "application/x-www-form-urlencoded; charset=utf-8",				
		//dataType: "text",	
		success : function(data) {
			//alert(JSON.stringify(data));
			var items = [];
			var inHTML = "";
			$.each(data.searchList, function(index, boardVO) { // each로 모든 데이터 가져와서 items 배열에 넣고

				//if(index==5)
				//return false; //break; true=>continue

				//배열에 푸쉬후 뿌려줄 영역에 html메소드로 넣기

				if (index == 0) {
					inHTML += "<div class=\"item active\">";
				} else {
					inHTML += "<div class=\"item\">";
				}
				inHTML += "<div class=\"col-md-4\">";
				inHTML += "<div class=\"card card-blog\">";
				inHTML += "<div class=\"card-image\">";
				inHTML += "<a href=\"#pablo\"> <img class=\"img img-raised\" src=\""+serviceMainImgPath+boardVO.board_srl+"/images/"+boardVO.main_image+"\">";
				inHTML += "</a>";
				inHTML += "<div class=\"colored-shadow\" style=\"background-image: url('" + serviceMainImgPath + boardVO.board_srl + "/images/" + boardVO.main_image + "'); opacity: 1;\"></div>";
				inHTML += "<div class=\"ripple-container\"></div>";
				inHTML += "</div>";
				inHTML += "<div class=\"card-content\">";
				inHTML += "<h6 class=\"category text-info\">" + boardVO.subcategory_srl + "</h6>";
				inHTML += "<h4 class=\"card-title\">";
				inHTML += "<a href=\"${pageContext.request.contextPath}/board/engineer/"+boardVO.board_srl+"\">" + boardVO.title + "</a>";
				inHTML += "</h4>";
				inHTML += "<p class=\"card-description text-left\">";
				
				inHTML +="서비스 지역 : " +boardVO.location+"<br/>";
				inHTML +="서비스 비용 : " +boardVO.service_cost+"<br/>";
				inHTML +="서비스 기간 : " +boardVO.service_time_start + " ~ " + boardVO.service_time_end+"<br/>";
			
			
				inHTML += "<a href=\"${pageContext.request.contextPath}/board/engineer/"+boardVO.board_srl+"\"> 자세히 보기 </a>";
				inHTML += "</p>";
				inHTML += "</div>";
				inHTML += "</div>";
				inHTML += "</div>";
				inHTML += "</div>";

				//inHTML+="<span><a href='./board/engineer/"+boardVO.board_srl+"?category="+hotKeyWord.category_srl+"&subcategory="+hotKeyWord.subcategory_srl+"'>"+hotKeyWord.searchword+"</a></span>");						

				
			});//each끝
			if (jQuery.isEmptyObject(data.searchList)) {
				$('#search_list_div').html("<div class=\"row\">해당 하는 검색 결과가 없습니다.</div>");
			} else {
				$('#search_list_div').html(inHTML);
			}

			$("#search_list_paging_div").html(data.pagingDiv);
			
			//alert(inHTML);
			//$('#hot_engineer_div').html(items);

		},

		error : function(e) {
			popLayerMsg("AJAX Error 발생" + e.status + ":" + e.statusText);
		}

	});
}

//TOP 인기 검색어
	$(document).ready(function() {

		var url = "${pageContext.request.contextPath}/board/json/top_search_list.json";

		var params = "category=${category_srl}&subcategory=${subcategory_srl}";
		//태그리스트 내용 지우기
		$("#tags").empty();

		//var params="";
		//alert(url);

		$.ajax({
			cache : false, // 캐시 사용 없애기
			type : 'post',
			url : url,
			param : params,
			//contentType: 'application/json; charset=utf-8',
			dataType : 'json',
			//contentType: "application/x-www-form-urlencoded; charset=utf-8",				
			//dataType: "text",	
			success : function(resdata) { //success에 성공했을 때 동작 넣기.

				//data= JSON.parse(resdata)

				var data;

				try {
					data = JSON.parse(JSON.stringify(resdata));
					//var data = JSON.parse( jsonData );								/* JSON 형식의 text 를 객체로 컨버팅 */
				} catch (e) {

					popLayerMsg(resdata + " : JSON 객체 파서 에러");
					popLayerMsg(" 페이지 JSON 객체 파서 에러 errURL : " + document.location + " , sendURL : " + url);

					return;
				}

				//alert(responseData.bbsList[0]);
				//var data = JSON.parse(responseData);

				//$("#bbs_content1").html("");

				//var key = Object.keys(data["bbsList"][0]); // 키 값 가져오기 num, title, content, id, postdate,visitcount, name, commentCnt

				var items = [];
				var tagInHTML = "";
				$.each(resdata.list, function(index, hotKeyWord) { // each로 모든 데이터 가져와서 items 배열에 넣고

					if (index == 10)
						return false; //break; true=>continue

					//배열에 푸쉬후 뿌려줄 영역에 html메소드로 넣기
					//items.push("<a class='title' href='bbs/bbs_detail.jsp?num=" + hotKeyWord.num + "&nowPage=1'>"+hotKeyWord.title+"</a>");
					//<a href='${pageContext.request.contextPath}/board/engineer?category="+hotKeyWord.category_srl+"&subcategory="+hotKeyWord.subcategory_srl+"' title='"+hotKeyWord.searchword+"'><i class='fa fa-tag'></i> "+hotKeyWord.searchword+"</a>
					tagInHTML += "<span><a href='${pageContext.request.contextPath}/board/engineer?category=" + hotKeyWord.category_srl + "&subcategory=" + hotKeyWord.subcategory_srl + "' title='10 Topics'><i class='fa fa-tag'></i> " + hotKeyWord.searchword + "</a></span>";

				});//each끝
				//alert(tagInHTML);
				$('#tags').html(tagInHTML);
				//$('#tagsList').html(items.join(''));
			},
			error : function(e) {
				popLayerMsg("AJAX Error 발생" + e.status + ":" + e.statusText);

			}
		});

		
		//서치 리스트
		//getServiceSearchList(nowPage, category_srl, subcategory_srl , board_type ,searchType,keyword
		//alert("${category_srl}, ${subcategory_srl} , ${board_type} ,${searchType},${keyword}");
		getServiceSearchList(1, null, null , "${board_type}" ,"${searchType}","${keyword}");
		
		//최초 서치 리스트		
		/* url = "${pageContext.request.contextPath}/board/json/service_list.json";
		var serviceMainImgPath = "${pageContext.request.contextPath}/resources/upload/service/";
		//내용 지우기
		$("#search_list_div").empty();
		var params = "board_type=${board_type}&pageSize=6&blockPage=5&keyword=${keyword}&searchType=tc";
		//alert(params);
		$.ajax({
			cache : false, // 캐시 사용 없애기
			type : 'post',
			url : url,
			data : params,
			//data : JSON.stringify({ board_type: 'E', pageSize: '3', blockPage: '1'}),
			//contentType: 'application/json; charset=utf-8',
			dataType : 'json',
			//contentType: "application/x-www-form-urlencoded; charset=utf-8",				
			//dataType: "text",	
			success : function(data) {
				//alert(JSON.stringify(data));
				var items = [];
				var inHTML = "";
				$.each(data.searchList, function(index, boardVO) { // each로 모든 데이터 가져와서 items 배열에 넣고

					//if(index==5)
					//return false; //break; true=>continue

					//배열에 푸쉬후 뿌려줄 영역에 html메소드로 넣기

					if (index == 0) {
						inHTML += "<div class=\"item active\">";
					} else {
						inHTML += "<div class=\"item\">";
					}
					inHTML += "<div class=\"col-md-4\">";
					inHTML += "<div class=\"card card-blog\">";
					inHTML += "<div class=\"card-image\">";
					inHTML += "<a href=\"#pablo\"> <img class=\"img img-raised\" src=\""+serviceMainImgPath+boardVO.board_srl+"/images/"+boardVO.main_image+"\">";
					inHTML += "</a>";
					inHTML += "<div class=\"colored-shadow\" style=\"background-image: url('" + serviceMainImgPath + boardVO.board_srl + "/images/" + boardVO.main_image + "'); opacity: 1;\"></div>";
					inHTML += "<div class=\"ripple-container\"></div>";
					inHTML += "</div>";
					inHTML += "<div class=\"card-content\">";
					inHTML += "<h6 class=\"category text-info\">" + boardVO.subcategory_srl + "</h6>";
					inHTML += "<h4 class=\"card-title\">";
					inHTML += "<a href=\"${pageContext.request.contextPath}/board/engineer/"+boardVO.board_srl+"\">" + boardVO.title + "</a>";
					inHTML += "</h4>";
					inHTML += "<p class=\"card-description\">";
					inHTML += boardVO.contents + "<a href=\"${pageContext.request.contextPath}/board/engineer/"+boardVO.board_srl+"\"> 자세히 보기 </a>";
					inHTML += "</p>";
					inHTML += "</div>";
					inHTML += "</div>";
					inHTML += "</div>";
					inHTML += "</div>";

					//inHTML+="<span><a href='./board/engineer/"+boardVO.board_srl+"?category="+hotKeyWord.category_srl+"&subcategory="+hotKeyWord.subcategory_srl+"'>"+hotKeyWord.searchword+"</a></span>");						

					
				});//each끝
				if (jQuery.isEmptyObject(data.searchList)) {
					$('#search_list_div').html("<div class=\"row\">해당 하는 검색 결과가 없습니다.</div>");
				} else {
					$('#search_list_div').html(inHTML);
				}

				$("#search_list_paging_div").html(data.pagingDiv);
				
				//alert(inHTML);
				//$('#hot_engineer_div').html(items);

			},

			error : function(e) {
				popLayerMsg("AJAX Error 발생" + e.status + ":" + e.statusText);
			}

		}); */

	});
</script>

</head>

<body>
	<!-- PRELOADER -->
	<img id="preloader" src="${pageContext.request.contextPath}/resources/images/preloader.gif" alt="" />
	<!-- //PRELOADER -->
	<div class="preloader_hide">

		<!-- HEADER -->

				<!-- header section -->
			<%@ include file="../../common/commonTop_1.jsp"%>
		<!--// header section -->
		<!-- header section -->
			<%@ include file="../../common/commonTop_2.jsp"%>
		<!--// header section -->

		<!-- Search List Area -->

		<!-- CONTAINER -->
		<section class="section-3 section-dark mt0">
			<div class="container">
				<div class="row">
					<div class="col-sm-10 col-sm-offset-1">
						<h2 class="section-title st2 mb25">현재 카테고리 인기 검색어 목록</h2>
						<div class="text-center">
							<div class="mb0">
							<h3 class="text-danger">현재 카테고리 인기 검색어 목록</h3>
								<div id="tags" class="tags">
									<a href="#" title="10 Topics"><i class="fa fa-tag"></i> 검색어</a> 
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</section>

		<section class="section-4">
			<div class="container">
				<div class="row">
					<div class="col-sm-7 col-md-9 col-md-push-3 col-sm-push-5 space-left push-off">
						<div id="portfolio-isotope">
							<div class="portfolio-container">
								<div id="search_list_div" class="row mt10">
									<div class="col-sm-6 col-md-3">
										<div class="blog-item">
											<div class="blog-image">
												<img src="${pageContext.request.contextPath}/resources/upload/service/1/images/mainimage.jpg" alt="blog post">
											</div>
											<div class="blog-caption">
												<h3 class="post-title">About Magento</h3>
												<div class="sub-post-title">
													<span>12 June, 2018</span> <span><i class="fa fa-user"></i> <a href="#"> by John Doe</a></span>
												</div>
												<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Veritatis, ipsum, optio.</p>
												<a href="blog_single_left.html" class="read-more">Read more</a>
											</div>
										</div>
									</div>
									
								</div>
							</div>
						</div>
						
						<div class="text-center">
						<ul class="pagination" id="search_list_paging_div">
							<li class="disabled"><a href="#"><i class="fa fa-chevron-left"></i></a></li>
							<li class="active"><a href="#">1</a></li>
							<li><a href="#">2</a></li>
							<li><a href="#">3</a></li>
							<li><a href="#">4</a></li>
							<li><a href="#">5</a></li>
							<li><a href="#"><i class="fa fa-chevron-right"></i></a></li>
						</ul>
						</div>
					</div>
					<div class="col-sm-5 col-md-3 col-md-pull-9 col-sm-pull-7 pull-off">
						<aside class="sidebar">
							<!-- 검색용 위젯 -->
							<div class="sidebar-widget">
								<form action="#" role="form">
									<div class="input-group">
										<input type="text" class="form-control" placeholder="Search"> <span class="input-group-btn">
											<button type="submit" class="btn btn-primary">
												<i class="fa fa-search"></i>
											</button>
										</span>
									</div>
								</form>
							</div>
							
							<!-- 카테고리별 서브카테고리 부분 -->
							<div class="sidebar-widget">
								<h3 class="sidebar-title mb30">서브 카테고리</h3>
								<ul class="categories">
								
									<li><a href="#"><span>1</span>목조</a></li>
									<li><a href="#"><span>2</span>단열</a></li>
									<li><a href="#"><span>3</span>창호</a></li>
									<li><a href="#"><span>4</span>내부마감</a></li>
									<li><a href="#"><span>5</span>외장마감</a></li>
									<li><a href="#"><span>6</span>설비</a></li>
									<li><a href="#"><span>7</span>전기</a></li>
									<li><a href="#"><span>8</span>징크</a></li>
									<li><a href="#"><span>9</span>설계&amp;디자인</a></li>
									<li><a href="#"><span>10</span>데크</a></li>
									
									
								</ul>
							</div>
							
							<!-- 최근/인기 게시글 -->
							<div class="sidebar-widget">
								<ul class="nav nav-tabs">
									<li class="active"><a href="#tab1" data-toggle="tab">최근 게시글</a></li>
									<li><a href="#tab2" data-toggle="tab">인기 게시글</a></li>
								</ul>
								<div class="tab-content">
									<div class="tab-pane fade in active" id="tab1">
										<ul class="latest-posts" id="latest-posts">
											<li>
												<div class="image-post">
													<img src="${pageContext.request.contextPath}/resources/upload/service/1/images/mainimage.jpg" alt="blog post">
												</div>
												<div class="info-post">
													<h5>
														<a href="blog_single_left.html">화장실 타일 공사해드립니다</a>
													</h5>
													<span>25 3월, 2018 </span>
												</div>
											</li>
											<li>
												<div class="image-post">
													<img src="${pageContext.request.contextPath}/resources/upload/service/1/images/mainimage.jpg" alt="blog post">
												</div>
												<div class="info-post">
													<h5>
														<a href="blog_single_left.html">주택 리모델링 해드립니다.</a>
													</h5>
													<span>27 3월, 2018 </span>
												</div>
											</li>
											<li>
												<div class="image-post">
													<img src="${pageContext.request.contextPath}/resources/upload/service/1/images/mainimage.jpg" alt="blog post">
												</div>
												<div class="info-post">
													<h5>
														<a href="blog_single_left.html">오래 된 모텔건물, 집 등 외벽을 철거없이 리모델링 해드립니다</a>
													</h5>
													<span>1 3월, 2018 </span>
												</div>
											</li>
										</ul>
									</div>
									<div class="tab-pane fade" id="tab2">
										<ul class="latest-posts" id="hot-posts">
											<li>
												<div class="image-post">
													<img src="${pageContext.request.contextPath}/resources/upload/service/1/images/mainimage.jpg" alt="blog post">
												</div>
												<div class="info-post">
													<h5>
														<a href="blog_single_left.html">싸게 주택 리모델링 해드립니다.</a>
													</h5>
													<span>10 2월, 2018 </span>
												</div>
											</li>
											<li>
												<div class="image-post">
													<img src="${pageContext.request.contextPath}/resources/upload/service/1/images/mainimage.jpg" alt="blog post">
												</div>
												<div class="info-post">
													<h5>
														<a href="blog_single_left.html">고객 만족 100% 화장실 타일 공사</a>
													</h5>
													<span>12 2월, 2018 </span>
												</div>
											</li>
											<li>
												<div class="image-post">
													<img src="${pageContext.request.contextPath}/resources/upload/service/1/images/mainimage.jpg" alt="blog post">
												</div>
												<div class="info-post">
													<h5>
														<a href="blog_single_left.html">값싸고 만족되는 석면철거,인테리어철거공사</a>
													</h5>
													<span>15 2월, 2018 </span>
												</div>
											</li>
										</ul>
									</div>
								</div>
							</div>
							
							
							

						</aside>
					</div>
				</div>
			</div>
		</section>


		<!-- //CONTAINER -->
		<!-- //HOME -->

		<!-- 모달창 -->
		<%@ include file="../../common/modal_msg.jsp"%>
		<!-- //모달창 끝 -->


		<!-- Footer section(하단부분) -->
		<!-- Bottom영역 -->
		<div class="row">
			<%@ include file="../../common/commonBottom.jsp"%>
		</div>
		<!-- Footer section(하단부분) -->

	</div>
</body>
</html>
