<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
  <div class="container">
    <a class="navbar-brand" href="<c:url value='/'/>">Web Shop</a>
    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#mainNav">
      <span class="navbar-toggler-icon"></span>
    </button>
    <div class="collapse navbar-collapse" id="mainNav">
      <ul class="navbar-nav me-auto mb-2 mb-lg-0">
        <li class="nav-item"><a class="nav-link" href="<c:url value='/products'/>">Products</a></li>
        <c:if test="${not empty sessionScope.userId}">
          <li class="nav-item"><a class="nav-link" href="<c:url value='/products/add'/>">Add Product</a></li>
        </c:if>
        <li class="nav-item"><a class="nav-link" href="<c:url value='/cart'/>">Cart</a></li>
      </ul>
      <ul class="navbar-nav ms-auto">
        <c:choose>
          <c:when test="${not empty sessionScope.userId}">
            <li class="nav-item"><span class="navbar-text me-2">Hello, ${sessionScope.userName}!</span></li>
            <li class="nav-item"><a class="btn btn-outline-light" href="<c:url value='/logout'/>">Logout</a></li>
          </c:when>
          <c:otherwise>
            <li class="nav-item me-2"><a class="btn btn-outline-light" href="<c:url value='/login.jsp'/>">Login</a></li>
            <li class="nav-item"><a class="btn btn-light" href="<c:url value='/register.jsp'/>">Register</a></li>
          </c:otherwise>
        </c:choose>
      </ul>
    </div>
  </div>
</nav>
