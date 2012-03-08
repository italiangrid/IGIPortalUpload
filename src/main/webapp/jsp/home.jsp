<%
/**
 * Copyright (c) 2000-2010 Liferay, Inc. All rights reserved.
 *
 * This library is free software; you can redistribute it and/or modify it under
 * the terms of the GNU Lesser General Public License as published by the Free
 * Software Foundation; either version 2.1 of the License, or (at your option)
 * any later version.
 *
 * This library is distributed in the hope that it will be useful, but WITHOUT
 * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
 * FOR A PARTICULAR PURPOSE. See the GNU Lesser General Public License for more
 * details.
 */
%>

<%@ include file="/jsp/init.jsp"%>
<c:if test="<%= !themeDisplay.isSignedIn() %>">
<strong>You aren't logged in.</strong>
</c:if>
<c:if test="<%= themeDisplay.isSignedIn() %>">
<c:set var="browser" value="${header['User-Agent']}" scope="session"/>
<c:choose>
<c:when test="${fn:contains(browser, 'MSIE')}">
	<br/>
	<p><strong>NOTICE:</strong></p>
	<p>
	You are using <strong>Microsoft Internet Explorer</strong> and you have some limitation in the upload file. If you want to use powerful uploader use <strong>Mozilla Firefox</strong> or <strong>Google Chrome</strong>.
	</p><br/>
	<%@include file="/jsp/plupload.jsp" %>
</c:when>
<c:otherwise>
	<%@include file="/jsp/jqueryfileupload.jsp" %>
</c:otherwise>
</c:choose>
</c:if>