<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Manage Registrations</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
</head>
<body class="bg-light">

<div class="container mt-5">
    <h2 class="text-center mb-4">🏃 Registration Management</h2>

    <table class="table table-bordered table-striped">
        <thead class="table-dark">
        <tr>
            <th>Reg ID</th>
            <th>Event ID</th>
            <th>Runner ID</th>
            <th>Register Date</th>
            <th>Payment Status</th>
            <th>Action</th>
        </tr>
        </thead>

        <tbody>
        <c:forEach var="r" items="${registrations}">
            <tr>
                <td>${r.regID}</td>
                <td>${r.event.eventName}</td>
                <td>${r.runner.fullName}</td>
                <td>${r.registerDate}</td>
                <td>
                    <c:choose>
                        <c:when test="${r.paymentStatus eq 'Paid'}">
                            <span class="badge bg-success">${r.paymentStatus}</span>
                        </c:when>
                        <c:otherwise>
                            <span class="badge bg-warning text-dark">${r.paymentStatus}</span>
                        </c:otherwise>
                    </c:choose>
                </td>

                <td>
                    <!-- Nếu đang Pending thì cho phép mark Paid -->
                    <c:if test="${r.paymentStatus eq 'Pending'}">
                        <form action="${pageContext.request.contextPath}/staffManager" method="post" style="display:inline;">
                            <input type="hidden" name="action" value="update">
                            <input type="hidden" name="regID" value="${r.regID}">
                            <input type="hidden" name="status" value="Paid">
                            <button type="submit" class="btn btn-sm btn-success"
                                    onclick="return confirm('Mark this registration as Paid?');">
                                Mark as Paid
                            </button>
                        </form>
                    </c:if>

                    <!-- Nút xóa -->
                    <form action="${pageContext.request.contextPath}/staffManager" method="get" style="display:inline;">
                        <input type="hidden" name="action" value="delete">
                        <input type="hidden" name="id" value="${r.regID}">
                        <button type="submit" class="btn btn-sm btn-danger"
                                onclick="return confirm('Are you sure to delete this registration?');">
                            Delete
                        </button>
                    </form>
                </td>
            </tr>
        </c:forEach>
        </tbody>
    </table>

    <div class="text-center mt-4">
        <a href="${pageContext.request.contextPath}/Home" class="btn btn-secondary">⬅ Back to Main</a>
    </div>
</div>

</body>
</html>
