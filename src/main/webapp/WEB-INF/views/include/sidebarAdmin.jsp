<%@ page contentType="text/html; charset=UTF-8" %>
<aside class="main-sidebar">
    <!-- sidebar: style can be found in sidebar.less -->
    <section class="sidebar">
      <!-- Sidebar user panel -->
      <!-- search form -->
      <!-- /.search form -->
      <!-- sidebar menu: : style can be found in sidebar.less -->
      <ul class="sidebar-menu">
        <li class="header">MAIN NAVIGATION</li>
        <li class="treeview">
          <a href="#">
            <i class="fa fa-users"></i>
            <span>회원관리</span>
            <span class="pull-right-container">
              <i class="fa fa-angle-left pull-right"></i>
            </span>
          </a>
          <ul class="treeview-menu">
            <li><a href="/admin/userList"><i class="fa fa-circle-o"></i>회원정보조회</a></li>
          </ul>
        </li>
        <li class="treeview">
          <a href="#">
            <i class="fa fa-dashboard"></i>
            <span>추가된 장소/한줄평 관리</span>
            <span class="pull-right-container">
              <i class="fa fa-angle-left pull-right"></i>
            </span>
          </a>
          <ul class="treeview-menu">
            <li><a href="/admin/board/notice"><i class="fa fa-circle-o"></i>공지사항게시판</a></li>
            <li><a href="/admin/board/faq"><i class="fa fa-circle-o"></i>FAQ게시판</a></li>
            <li><a href="/admin/board/qna"><i class="fa fa-circle-o"></i>Q&amp;A게시판</a></li>
          </ul>
        </li>
      </ul>
    </section>
    <!-- /.sidebar -->
  </aside>