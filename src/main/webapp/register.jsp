<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Register – Web Shop</title>
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="d-flex flex-column min-vh-100 bg-light">
  <jsp:include page="/WEB-INF/views/parts/header.jsp"/>

  <main class="container flex-grow-1 py-5">
    <div class="bg-primary text-white rounded-3 p-4 p-md-5 mb-5">
      <h1 class="h2 fw-bold mb-1">Create your account</h1>
    </div>
    <div class="row justify-content-center">
      <div class="col-12 col-md-8 col-lg-5">
        <div class="card shadow border-0">
          <div class="card-body p-4 p-md-5">
            <h2 class="h4 mb-4">Register</h2>
            <c:if test="${not empty param.error}">
              <div class="alert alert-danger" role="alert">${param.error}</div>
            </c:if>
            <form action="<c:url value='/register'/>" method="post" class="needs-validation" novalidate>
              <div class="form-floating mb-3">
                <input type="text" class="form-control" id="fullName" name="fullName" placeholder="Jane Doe" required>
                <label for="fullName">Full name</label>
                <div class="invalid-feedback">Please enter your name.</div>
              </div>
              <div class="form-floating mb-3">
                <input type="email" class="form-control" id="email" name="email" placeholder="name@example.com" required>
                <label for="email">Email address</label>
                <div class="invalid-feedback">Please enter a valid email.</div>
              </div>
              <div class="form-floating mb-4">
                <input type="password" class="form-control" id="password" name="password" placeholder="••••••••" required>
                <label for="password">Password</label>
                <div class="invalid-feedback">Password is required.</div>
              </div>
              <div class="d-grid gap-2">
                <button type="submit" class="btn btn-primary btn-lg">Create Account</button>
              </div>
            </form>
            <hr class="my-4">
            <p class="mb-0 text-muted">Already have an account? <a href="<c:url value='/login.jsp'/>" class="link-primary">Sign in</a></p>
          </div>
        </div>
      </div>
    </div>
  </main>

  <jsp:include page="/WEB-INF/views/parts/footer.jsp"/>
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
  <script>
    (() => {
      const forms = document.querySelectorAll('.needs-validation');
      Array.from(forms).forEach(form => {
        form.addEventListener('submit', e => {
          if (!form.checkValidity()) { e.preventDefault(); e.stopPropagation(); }
          form.classList.add('was-validated');
        }, false);
      });
    })();
  </script>
</body>
</html>
