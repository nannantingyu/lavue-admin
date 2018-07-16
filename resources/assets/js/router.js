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
        }
    ]
})