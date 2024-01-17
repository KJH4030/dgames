<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<table class="table table-sm">
          <caption style="display: table-caption;text-align: center;color: red;font-weight: bold;">[주문상세정보]</caption>
          <thead>
            <tr>
              <th scope="col">주문번호</th>
              <th scope="col">상품코드</th>
              <th scope="col">상품이미지</th>
              <th scope="col">상품명</th>
              <th scope="col">주문금액</th>
              
            </tr>
          </thead>
          <tbody>
            <c:forEach items="${orderGameList }" var="orderGameVO">
            <tr>
              <th scope="row">${orderGameVO.orderDetailVO.ord_code}</th>
              <td>${orderGameVO.gameVO.game_id}</td>
              <td><img src="/admin/order/imageDisplay?dateFolderName=${orderGameVO.gameVO.img_up_folder}&fileName=${orderGameVO.gameVO.game_img}"></td>
              <td>${orderGameVO.gameVO.game_title}</td>
              <td>${orderGameVO.gameVO.game_price}</td>
              
            </tr>
            </c:forEach>
          </tbody>
        </table>
