<%--
  HelixEMR Patient List
  Helix Health – Enterprise Electronic Medical Record System
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c"   uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<%@ taglib prefix="fn"  uri="jakarta.tags.functions" %>

<c:set var="activePage" value="patients" scope="request"/>

<jsp:include page="/WEB-INF/view/layouts/layout-top.jsp" flush="true"/>

<!-- Search bar -->
<div class="helix-card" style="margin-bottom:var(--helix-space-lg);">
    <form method="GET" action="${pageContext.request.contextPath}/helixemr/patients"
          class="helix-d-flex helix-gap-md helix-align-center" style="flex-wrap:wrap;">
        <input type="text"
               name="q"
               value="${fn:escapeXml(query)}"
               class="helix-input"
               placeholder="Search by name, MRN, or identifier…"
               style="flex:1; min-width:200px;"
               aria-label="Patient search"/>
        <button type="submit" class="helix-btn helix-btn-primary">Search</button>
        <a href="${pageContext.request.contextPath}/helixemr/patients/add"
           class="helix-btn helix-btn-outline">+ Register Patient</a>
    </form>
</div>

<!-- Results table -->
<div class="helix-card">
    <div class="helix-card-header">
        <h2 class="helix-card-title">
            Patients
            <c:if test="${not empty query}">
                &mdash; Results for "<c:out value="${query}"/>"
            </c:if>
        </h2>
        <span class="helix-text-muted" style="font-size:13px;">
            <fmt:formatNumber value="${total}"/> record(s)
        </span>
    </div>

    <div class="helix-table-wrapper">
        <table class="helix-table" role="grid">
            <thead>
                <tr>
                    <th>MRN</th>
                    <th>Name</th>
                    <th>Gender</th>
                    <th>Date of Birth</th>
                    <th>Status</th>
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody>
                <c:choose>
                    <c:when test="${empty patients}">
                        <tr>
                            <td colspan="6" style="text-align:center; padding:32px;
                                color:var(--helix-text-secondary);">
                                No patients found.
                                <a href="${pageContext.request.contextPath}/helixemr/patients/add">
                                    Register a new patient
                                </a>
                            </td>
                        </tr>
                    </c:when>
                    <c:otherwise>
                        <c:forEach var="patient" items="${patients}">
                            <tr>
                                <td>
                                    <span style="font-family:var(--helix-font-mono); font-size:12px;">
                                        <c:out value="${patient.medicalRecordNumber}"/>
                                    </span>
                                </td>
                                <td>
                                    <a href="${pageContext.request.contextPath}/helixemr/patients/${patient.patientId}"
                                       style="font-weight:600;">
                                        <c:out value="${patient}"/>
                                    </a>
                                </td>
                                <td><c:out value="${patient.gender}"/></td>
                                <td>
                                    <%-- birthdate is LocalDate; toString() gives ISO-8601 --%>
                                    <c:out value="${patient.birthdate}"/>
                                </td>
                                <td>
                                    <c:choose>
                                        <c:when test="${patient.voided}">
                                            <span class="helix-badge helix-badge-inactive">Voided</span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="helix-badge helix-badge-active">Active</span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td>
                                    <a href="${pageContext.request.contextPath}/helixemr/patients/${patient.patientId}"
                                       class="helix-btn helix-btn-outline helix-btn-sm">
                                        View
                                    </a>
                                </td>
                            </tr>
                        </c:forEach>
                    </c:otherwise>
                </c:choose>
            </tbody>
        </table>
    </div>
</div>

<jsp:include page="/WEB-INF/view/layouts/layout-bottom.jsp" flush="true"/>
