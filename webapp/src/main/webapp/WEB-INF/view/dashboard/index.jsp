<%--
  HelixEMR Dashboard
  Helix Health – Enterprise Electronic Medical Record System
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<c:set var="activePage" value="dashboard" scope="request"/>

<jsp:include page="/WEB-INF/view/layouts/layout-top.jsp" flush="true"/>

<!-- ============================================================
     Stat Cards
     ============================================================ -->
<div class="helix-stats-grid">
    <div class="helix-stat-card">
        <div class="helix-stat-label">Total Patients</div>
        <div class="helix-stat-value">
            <fmt:formatNumber value="${totalPatients}" groupingUsed="true"/>
        </div>
        <div class="helix-stat-trend">&#x2191; Active Registry</div>
    </div>

    <div class="helix-stat-card success">
        <div class="helix-stat-label">Encounters Today</div>
        <div class="helix-stat-value">0</div>
        <div class="helix-stat-trend" style="color:var(--helix-success);">Clinic Open</div>
    </div>

    <div class="helix-stat-card accent">
        <div class="helix-stat-label">Active Visits</div>
        <div class="helix-stat-value">0</div>
        <div class="helix-stat-trend" style="color:var(--helix-accent);">In-Patient</div>
    </div>

    <div class="helix-stat-card info">
        <div class="helix-stat-label">Pending Orders</div>
        <div class="helix-stat-value">0</div>
        <div class="helix-stat-trend" style="color:var(--helix-info);">Awaiting Review</div>
    </div>
</div>

<!-- ============================================================
     Quick Actions
     ============================================================ -->
<div class="helix-card">
    <div class="helix-card-header">
        <h2 class="helix-card-title">Quick Actions</h2>
    </div>
    <div class="helix-d-flex helix-gap-md" style="flex-wrap:wrap;">
        <a href="${pageContext.request.contextPath}/helixemr/patients/add"
           class="helix-btn helix-btn-primary">
            + Register Patient
        </a>
        <a href="${pageContext.request.contextPath}/helixemr/patients"
           class="helix-btn helix-btn-outline">
            Search Patients
        </a>
        <a href="${pageContext.request.contextPath}/helixemr/reports"
           class="helix-btn helix-btn-outline">
            View Reports
        </a>
    </div>
</div>

<!-- ============================================================
     System Info
     ============================================================ -->
<div class="helix-card">
    <div class="helix-card-header">
        <h2 class="helix-card-title">System Status</h2>
        <span class="helix-badge helix-badge-active">Operational</span>
    </div>
    <table class="helix-table">
        <tbody>
            <tr>
                <td style="font-weight:600; width:200px;">Application</td>
                <td>HelixEMR</td>
            </tr>
            <tr>
                <td style="font-weight:600;">Version</td>
                <td>1.0.0</td>
            </tr>
            <tr>
                <td style="font-weight:600;">Vendor</td>
                <td>Helix Health &mdash; <a href="https://helixhealth.io">helixhealth.io</a></td>
            </tr>
            <tr>
                <td style="font-weight:600;">Platform</td>
                <td>HelixEMR Platform (MPL 2.0)</td>
            </tr>
            <tr>
                <td style="font-weight:600;">Date</td>
                <%-- LocalDate.toString() produces ISO-8601 (e.g. "2024-01-15") --%>
                <td><c:out value="${today}"/></td>
            </tr>
        </tbody>
    </table>
</div>

<jsp:include page="/WEB-INF/view/layouts/layout-bottom.jsp" flush="true"/>
