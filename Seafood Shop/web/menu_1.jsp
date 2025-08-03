

<style>
    .menu {
        background-color: #333;
        padding: 20px;
        width: 200px;
        height: calc(100vh - 70px); /* Tr? ?i chi?u cao c?a header */
        position: fixed;
        left: 0;
        top: 80px; /* ??t menu bên d??i header */
        display: flex;
        flex-direction: column;
        gap: 30px;
    }

    .menu a {
        color: white;
        text-decoration: none;
        padding: 12px 15px;
        border-radius: 5px;
        background-color: #555;
        text-align: center;
    }

    .menu a:hover {
        background-color: #777;
        padding: 10px
    }

    /* ?? n?i dung không b? che b?i menu */
    .content {
        margin-left: 220px;
        padding: 20px;
    }
</style>

<div class="menu">
    <a href='HomeController'>Home Page</a>
    <a href='ProductController?action=productList'>Product Page</a>
    <a href='CustomersController?action=customerList'>Customer Page</a>
    <a href='InvoiceController?action=orderManage'>Order Page</a>
    <a href='LoginAdminController?action=Logout'>Logout</a>
</div>
