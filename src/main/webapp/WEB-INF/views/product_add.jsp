<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Add Product – Web Shop</title>
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="d-flex flex-column min-vh-100 bg-light">
  <jsp:include page="/WEB-INF/views/parts/header.jsp"/>

  <main class="container flex-grow-1 py-5">
    <div class="bg-primary text-white rounded-3 p-4 p-md-5 mb-5">
      <h1 class="h3 fw-bold mb-0">Add Product</h1>
    </div>

    <div class="row justify-content-center">
      <div class="col-12 col-md-8 col-lg-6">
        <div class="card shadow border-0">
          <div class="card-body p-4 p-md-5">
            <c:if test="${not empty error}">
              <div class="alert alert-danger" role="alert">${error}</div>
            </c:if>
            <form action="<c:url value='/products/add'/>" method="post" enctype="multipart/form-data" class="needs-validation" novalidate>
              <div class="form-floating mb-3">
                <input type="text" class="form-control" id="name" name="name" placeholder="Name" value="${name}" required>
                <label for="name">Name</label>
                <div class="invalid-feedback">Required.</div>
              </div>
              <div class="mb-3">
                <label for="description" class="form-label">Description</label>
                <textarea class="form-control" id="description" name="description" rows="4">${description}</textarea>
              </div>
              <div class="row g-3">
                <div class="col-md-6">
                  <div class="form-floating">
                    <input type="number" step="0.01" min="0" class="form-control" id="price" name="price" placeholder="0.00" value="${price}" required>
                    <label for="price">Price (LKR)</label>
                    <div class="invalid-feedback">Enter a valid amount.</div>
                  </div>
                </div>
                <div class="col-md-6">
                  <div class="form-floating">
                    <input type="number" min="0" class="form-control" id="stock" name="stock" placeholder="0" value="${stock}" required>
                    <label for="stock">Stock</label>
                    <div class="invalid-feedback">Enter a valid quantity.</div>
                  </div>
                </div>
              </div>
              <div class="mb-3">
                <label for="image" class="form-label">Image</label>
                <input class="form-control" type="file" id="image" name="image" accept="image/png,image/jpeg,image/webp">
                <div class="form-text">PNG, JPEG, or WebP up to 5 MB.</div>
              </div>
              <div class="d-flex gap-2">
                <button type="submit" class="btn btn-primary btn-lg">Save Product</button>
                <a href="<c:url value='/products'/>" class="btn btn-outline-secondary btn-lg">Cancel</a>
              </div>
            </form>
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
