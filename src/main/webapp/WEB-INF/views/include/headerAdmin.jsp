<%@ page pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<meta name="_csrf_header" content="X-CSRF-TOKEN" />
<meta name="${_csrf.parameterName}" content="${_csrf.token}" />

  <header class="main-header">
    <!-- Logo -->
    <a href="/admin/main" class="logo">
      <!-- mini logo for sidebar mini 50x50 pixels -->
      <span class="logo-mini"><b>in</b>S</span>
      <!-- logo for regular state and mobile devices -->
      <span class="logo-lg"><b>in</b>Search</span>
    </a>
    <!-- Header Navbar: style can be found in header.less -->
    <nav class="navbar navbar-static-top">
      <!-- Sidebar toggle button-->
      <a href="#" class="sidebar-toggle" data-toggle="offcanvas" role="button">
        <span class="sr-only">Toggle navigation</span>
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>
      </a>

      <div class="navbar-custom-menu">
        <ul class="nav navbar-nav">
          <!-- User Account: style can be found in dropdown.less -->
          <li class="dropdown user user-menu">
            <a href="#" class="dropdown-toggle" data-toggle="dropdown">
              <img src="http://placehold.it/160x160.jpg" class="user-image" alt="User Image">
              <span class="hidden-xs">inSearch</span>
            </a>
            <ul class="dropdown-menu">
              <!-- User image -->
              <li class="user-header">
                <img src="http://placehold.it/160x160.jpg" class="img-circle" alt="User Image">
                <p>
                  inSearch
                  <small>Member since Nov. 2017</small>
                </p>
              </li>
              <!-- Menu Footer-->
              <li class="user-footer">
	              <div class="pull-right">
	                <form action="<c:url value='/admin/logout' />" method="post">		
					  <input type="submit" value="LogOut" />
					  <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
					</form>
				  </div>
              </li>
            </ul>
          </li>
          <!-- Control Sidebar Toggle Button -->
        </ul>
      </div>
    </nav>
  </header>
