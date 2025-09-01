<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Order Success – Web Shop</title>
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="d-flex flex-column min-vh-100 bg-light">
  <jsp:include page="/WEB-INF/views/parts/header.jsp"/>

  <main class="container py-5 flex-grow-1">
    <div class="row justify-content-center">
      <div class="col-12 col-lg-8">
        <div class="card border-0 shadow-lg rounded-4">
          <div class="card-body p-5 text-center">
            <h1 class="h3 fw-bold mb-3">Thank you for your purchase!</h1>
            <p class="lead mb-4">Your order has been placed successfully.</p>
            <p class="mb-5"><span class="text-muted">Order ID:</span> <span class="fw-semibold">#${orderId}</span></p>
            <a href="<c:url value='/products'/>" class="btn btn-primary btn-lg">Continue Shopping</a>
          </div>
        </div>
      </div>
    </div>
  </main>

  <jsp:include page="/WEB-INF/views/parts/footer.jsp"/>
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
