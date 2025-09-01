<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%
  com.gim.webapp.dao.ProductDao dao = new com.gim.webapp.dao.ProductDao();
  java.util.List<com.gim.webapp.model.Product> featured = dao.searchByNameLike("", 0, 8);
  request.setAttribute("featured", featured);
%>

<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Web Shop</title>
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="d-flex flex-column min-vh-100 bg-light">
  <jsp:include page="/WEB-INF/views/parts/header.jsp"/>

  <main class="container py-5 flex-grow-1">
    <section class="p-5 bg-primary text-white rounded-4 mb-5">
      <div class="row align-items-center g-4">
        <div class="col-lg-8">
          <h1 class="display-5 fw-bold">Shop smart with <span class="text-white">Web Shop</span></h1>
          <p class="lead mb-4">Laptops, phones, and accessories at great prices.</p>
          <a href="<c:url value='/products'/>" class="btn btn-light btn-lg me-2">Browse Products</a>
          <c:choose>
            <c:when test="${not empty sessionScope.userId}">
              <a href="<c:url value='/cart'/>" class="btn btn-outline-light btn-lg">Go to Cart</a>
            </c:when>
            <c:otherwise>
              <a href="<c:url value='/register.jsp'/>" class="btn btn-outline-light btn-lg">Create Account</a>
            </c:otherwise>
          </c:choose>
        </div>
      </div>
    </section>

    <section class="mb-4">
      <div class="d-flex justify-content-between align-items-center mb-3">
        <h2 class="h4 mb-0">Featured Products</h2>
        <a class="btn btn-sm btn-outline-primary" href="<c:url value='/products'/>">View all</a>
      </div>

      <div class="row g-4">
        <c:forEach var="p" items="${featured}">
          <div class="col-12 col-sm-6 col-lg-4 col-xl-3">
            <div class="card h-100 border-0 shadow-lg rounded-4">
              <c:choose>
                <c:when test="${not empty p.imageUrl}">
                  <div class="ratio ratio-4x3 bg-body-tertiary rounded-top-4">
                    <img src="<c:url value='${p.imageUrl}'/>"
                         alt="<c:out value='${p.name}'/>"
                         class="w-100 h-100 object-fit-contain p-3">
                  </div>
                </c:when>
                <c:otherwise>
                  <div class="ratio ratio-4x3 bg-body-tertiary rounded-top-4 d-flex align-items-center justify-content-center text-secondary">
                    No image
                  </div>
                </c:otherwise>
              </c:choose>

              <div class="card-body d-flex flex-column">
                <h3 class="fs-6 fw-semibold mb-1 text-truncate"><c:out value="${p.name}"/></h3>
                <p class="text-secondary small flex-grow-1 mb-3"><c:out value="${p.description}"/></p>
                <div class="d-flex justify-content-between align-items-center">
                  <span class="fs-5 fw-bold text-primary">
                    LKR <fmt:formatNumber value="${p.price}" minFractionDigits="2" maxFractionDigits="2"/>
                  </span>
                  <c:choose>
                    <c:when test="${p.stock gt 0}">
                      <span class="badge text-bg-success">${p.stock} in stock</span>
                    </c:when>
                    <c:otherwise>
                      <span class="badge text-bg-secondary">Out of stock</span>
                    </c:otherwise>
                  </c:choose>
                </div>
              </div>

              <div class="card-footer bg-white border-0 pt-0 px-4 pb-4">
                <c:choose>
                  <c:when test="${p.stock gt 0}">
                    <form action="<c:url value='/cart/add'/>" method="post" class="input-group">
                      <input type="hidden" name="productId" value="${p.id}">
                      <input type="number" name="qty" value="1" min="1" max="${p.stock}" class="form-control">
                      <button type="submit" class="btn btn-primary">Add to Cart</button>
                    </form>
                  </c:when>
                  <c:otherwise>
                    <button class="btn btn-secondary w-100" disabled>Out of stock</button>
                  </c:otherwise>
                </c:choose>
              </div>
            </div>
          </div>
        </c:forEach>
      </div>
    </section>
  </main>

  <jsp:include page="/WEB-INF/views/parts/footer.jsp"/>
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
