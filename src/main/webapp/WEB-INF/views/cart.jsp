<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <title>Your Cart – Web Shop</title>
  <meta name="viewport" content="width=device-width, initial-scale=1" />
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" />
</head>
<body class="d-flex flex-column min-vh-100 bg-light">
  <jsp:include page="/WEB-INF/views/parts/header.jsp"/>

  <main class="container flex-grow-1 py-5">
    <h1 class="h3 mb-3">Your Cart</h1>

    <c:if test="${not empty error}">
      <div class="alert alert-danger">${error}<c:if test="${not empty oosProductName}"> (${oosProductName})</c:if></div>
    </c:if>

    <c:set var="cart" value="${sessionScope.cart}"/>
    <c:choose>
      <c:when test="${empty cart}">
        <div class="alert alert-info">
          Your cart is empty.
          <a class="alert-link" href="<c:url value='/products'/>">Browse products</a>
        </div>
      </c:when>

      <c:otherwise>
        <form action="<c:url value='/cart/update'/>" method="post" class="mb-4" id="cartForm">
          <div class="table-responsive">
            <table class="table table-hover align-middle bg-white">
              <thead class="table-light">
                <tr>
                  <th>Product</th>
                  <th style="width: 140px;">Price</th>
                  <th style="width: 120px;">Qty</th>
                  <th style="width: 160px;">Total</th>
                </tr>
              </thead>
              <tbody>
                <c:forEach items="${cart}" var="entry">
                  <c:set var="item" value="${entry.value}"/>
                  <tr class="${oosProductId != null and item.productId == oosProductId ? 'table-danger' : ''}">
                    <td>
                      <div class="d-flex align-items-center gap-3">
                        <c:if test="${not empty item.imageUrl}">
                          <img
                            src="<c:url value='${item.imageUrl}'/>"
                            alt="<c:out value='${item.name}'/>"
                            style="width:56px;height:56px;object-fit:cover;border-radius:.5rem;border:1px solid #eee;"
                          />
                        </c:if>
                        <span><c:out value="${item.name}"/></span>
                      </div>
                    </td>
                    <td>
                      LKR <fmt:formatNumber value="${item.unitPrice}" minFractionDigits="2" maxFractionDigits="2"/>
                    </td>
                    <td>
                      <input class="form-control form-control-sm" type="number"
                             name="qty_${item.productId}" min="0" value="${item.quantity}">
                    </td>
                    <td class="fw-semibold">
                      LKR <fmt:formatNumber value="${item.lineTotal}" minFractionDigits="2" maxFractionDigits="2"/>
                    </td>
                  </tr>
                </c:forEach>
              </tbody>
            </table>
          </div>

          <div class="d-flex justify-content-between flex-wrap gap-2">
            <a class="btn btn-outline-secondary" href="<c:url value='/products'/>">Continue Shopping</a>
            <div class="d-flex gap-2">
              <button type="submit" name="action" value="update" class="btn btn-outline-primary">Update Cart</button>
              <button type="submit" name="action" value="checkout" class="btn btn-primary btn-lg">Checkout</button>
            </div>
          </div>

          <div class="card border-0 shadow-sm mt-4">
            <div class="card-body d-flex justify-content-between align-items-center">
              <div class="fs-5">
                Grand Total:
                <strong>LKR <fmt:formatNumber value="${total}" minFractionDigits="2" maxFractionDigits="2"/></strong>
              </div>
            </div>
          </div>
        </form>
      </c:otherwise>
    </c:choose>
  </main>

  <jsp:include page="/WEB-INF/views/parts/footer.jsp"/>
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
