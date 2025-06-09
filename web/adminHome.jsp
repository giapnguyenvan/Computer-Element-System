<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    model.User user = (model.User) session.getAttribute("userAuth");
%>
<style>
    body.admin-home-bg {
        background: linear-gradient(135deg, #f9d423 0%, #ff4e50 50%, #24c6dc 100%);
        min-height: 100vh;
        font-family: 'Baloo 2', 'Comic Sans MS', cursive, sans-serif;
    }
    .admin-home-card {
        background: #fffbe7;
        border-radius: 32px;
        box-shadow: 0 8px 32px 0 rgba(31, 38, 135, 0.18);
        padding: 48px 32px 32px 32px;
        max-width: 700px;
        margin: 48px auto 0 auto;
        text-align: center;
        position: relative;
        overflow: visible;
    }
    .admin-home-avatar {
        width: 120px;
        height: 120px;
        border-radius: 50%;
        box-shadow: 0 4px 16px rgba(111,66,193,0.15);
        margin-bottom: 18px;
        border: 5px solid #ffb347;
        background: #fff;
        position: relative;
        z-index: 1;
    }
    .admin-home-sticker {
        position: absolute;
        top: 10px;
        right: 18px;
        font-size: 2.2rem;
        z-index: 2;
        transform: rotate(18deg);
        pointer-events: none;
    }
    .admin-home-title {
        font-size: 2.5rem;
        font-weight: 800;
        color: #ff4e50;
        margin-bottom: 10px;
        letter-spacing: 1px;
        text-shadow: 1px 2px 0 #fffbe7, 2px 4px 0 #ffe082;
    }
    .admin-home-desc {
        color: #555;
        font-size: 1.15rem;
        margin-bottom: 32px;
        font-weight: 500;
    }
    .admin-home-shortcuts {
        display: flex;
        flex-wrap: wrap;
        gap: 22px;
        justify-content: center;
    }
    .admin-home-shortcut-btn {
        min-width: 170px;
        padding: 20px 0;
        border-radius: 18px;
        font-size: 1.12rem;
        font-weight: 600;
        box-shadow: 0 2px 12px rgba(255, 78, 80, 0.09);
        border: none;
        background: linear-gradient(90deg, #f9d423 0%, #ff4e50 100%);
        color: #fff;
        display: flex;
        align-items: center;
        justify-content: center;
        gap: 12px;
        transition: transform 0.18s, box-shadow 0.18s, background 0.18s;
        position: relative;
        overflow: hidden;
    }
    .admin-home-shortcut-btn:hover {
        background: linear-gradient(90deg, #24c6dc 0%, #5433ff 100%);
        color: #fff;
        transform: translateY(-4px) scale(1.06) rotate(-2deg);
        box-shadow: 0 8px 24px rgba(36,198,220,0.13);
        text-decoration: none;
    }
    .admin-home-shortcut-btn i {
        font-size: 1.7rem;
        transition: transform 0.18s;
    }
    .admin-home-shortcut-btn:hover i {
        animation: shake 0.5s;
    }
    @keyframes shake {
        10%, 90% { transform: translateX(-2px); }
        20%, 80% { transform: translateX(4px); }
        30%, 50%, 70% { transform: translateX(-6px); }
        40%, 60% { transform: translateX(6px); }
    }
    @media (max-width: 600px) {
        .admin-home-card { padding: 18px 6px; }
        .admin-home-title { font-size: 1.3rem; }
        .admin-home-shortcut-btn { min-width: 120px; font-size: 0.98rem; }
    }
    /* Confetti */
    .confetti {
        position: fixed;
        left: 0; top: 0; width: 100vw; height: 100vh;
        pointer-events: none;
        z-index: 9999;
        font-size: 2rem;
        animation: confetti-fall 2.5s linear forwards;
    }
    @keyframes confetti-fall {
        0% { transform: translateY(-100px); opacity: 0; }
        10% { opacity: 1; }
        100% { transform: translateY(100vh); opacity: 0; }
    }
</style>
<link href="https://fonts.googleapis.com/css2?family=Baloo+2:wght@600;800&display=swap" rel="stylesheet">
<script>
    document.body.classList.add('admin-home-bg');
    // Confetti effect
    window.addEventListener('DOMContentLoaded', function() {
        for (let i = 0; i < 18; i++) {
            const conf = document.createElement('div');
            conf.className = 'confetti';
            conf.style.left = Math.random() * 100 + 'vw';
            conf.style.animationDelay = (Math.random() * 0.8) + 's';
            conf.textContent = ['🎉','✨','🎈','🥳','💥','🌈','🍭','🦄'][Math.floor(Math.random()*8)];
            document.body.appendChild(conf);
            setTimeout(()=>conf.remove(), 2600);
        }
    });
</script>
<div class="admin-home-card">
    <span class="admin-home-sticker">🦄</span>
    <img src="${pageContext.request.contextPath}/assets/admin-avartar.png.jpg" alt="Admin Avatar" class="admin-home-avatar">
    <div class="admin-home-title">Heyyy, <span>${user.fullname} 🎉</span>!</div>
    <div class="admin-home-desc">
        Welcome to your <b>super admin playground</b>!<br>
        🚀 Let's make some magic: manage products, customers, blogs, feedback and more.<br>
        Have a fun-tastic day! 🍭
    </div>
    <div class="admin-home-shortcuts">
        <a href="${pageContext.request.contextPath}/categoryList.jsp" target="mainFrame" class="admin-home-shortcut-btn">
            <i class="fas fa-list"></i> Categories
        </a>
        <a href="${pageContext.request.contextPath}/productservlet" target="mainFrame" class="admin-home-shortcut-btn">
            <i class="fas fa-box"></i> Products
        </a>
        <a href="${pageContext.request.contextPath}/viewcustomers" target="mainFrame" class="admin-home-shortcut-btn">
            <i class="fas fa-users"></i> Customers
        </a>
        <a href="${pageContext.request.contextPath}/viewblogs" target="mainFrame" class="admin-home-shortcut-btn">
            <i class="fas fa-blog"></i> Blogs
        </a>
        <a href="${pageContext.request.contextPath}/viewfeedback" target="mainFrame" class="admin-home-shortcut-btn">
            <i class="fas fa-comments"></i> Feedback
        </a>
    </div>
</div> 