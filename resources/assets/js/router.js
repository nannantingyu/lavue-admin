import Vue from 'vue'
import VueRouter from 'vue-router'
Vue.use(VueRouter)

export default new VueRouter({
    routes: [
        {
            name: 'index',
            path: '/index',
            component: resolve=>void(require(['./page/index.vue'], resolve))
        },
        {
            name: 'login',
            path: '/login',
            component: resolve=>void(require(['./page/login.vue'], resolve))
        },
        {
            name: 'user',
            path: '/user',
            component: resolve=>void(require(['./page/user.vue'], resolve))
        },
        {
            name: 'add-user',
            path: '/add-user',
            component: resolve=>void(require(['./page/add-user.vue'], resolve))
        },
        {
            name: 'module',
            path: '/module',
            component: resolve=>void(require(['./page/module.vue'], resolve))
        },
        {
            name: 'add-module',
            path: '/add-module',
            component: resolve=>void(require(['./page/add-module.vue'], resolve))
        },
        {
            name: 'add-role',
            path: '/add-role',
            component: resolve=>void(require(['./page/add-role.vue'], resolve))
        },
        {
            name: 'role-user',
            path: '/role-user',
            component: resolve=>void(require(['./page/role-user.vue'], resolve))
        },
        {
            name: 'permission',
            path: '/permission',
            component: resolve=>void(require(['./page/permission.vue'], resolve))
        },
        {
            name: 'article',
            path: '/article',
            component: resolve=>void(require(['./page/article.vue'], resolve))
        },
        {
            name: "article-edit",
            path: '/article-edit/:id?',
            component: resolve =>void(require(['./page/add-article.vue'], resolve))
        },
        {
            name: "config",
            path: '/config',
            component: resolve =>void(require(['./page/config.vue'], resolve))
        },
        {
            name: "hot-banner",
            path: '/hot-banner',
            component: resolve =>void(require(['./page/hot-banner.vue'], resolve))
        },
        {
            name: "company",
            path: '/company',
            component: resolve =>void(require(['./page/company.vue'], resolve))
        },
        {
            name: "category",
            path: '/category',
            component: resolve =>void(require(['./page/category.vue'], resolve))
        },
        {
            name: "category-company",
            path: '/category-company',
            component: resolve =>void(require(['./page/category-company.vue'], resolve))
        },
    ]
})