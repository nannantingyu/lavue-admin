<template>
    <el-container>
        <el-aside width="*">
            <el-switch
                    v-model="isCollapse"
                    active-color="#ff4949"
                    inactive-color="#13ce66">
            </el-switch>
            <el-menu :default-active="$route.path"
                     class="el-menu-vertical-demo"
                     router
                     :collapse="isCollapse">
                <el-menu-item
                        v-if="user_module_permission['index-read']"
                        index="/index">
                    <i class="el-icon-tickets"></i>
                    <span slot="title">首页</span>
                </el-menu-item>
                <el-submenu
                        v-if="user_module_permission['article-read']"
                        index="/article">
                    <template slot="title">
                        <i class="el-icon-tickets"></i>
                        <span slot="title">文章管理</span>
                    </template>
                    <el-menu-item-group>
                        <el-menu-item
                                v-if="user_module_permission['article-read']"
                                index="/article">
                            <i class="el-icon-tickets"></i>
                            <span slot="title">文章列表</span>
                        </el-menu-item>
                        <el-menu-item
                                v-if="user_module_permission['add-article-read']"
                                index="/add-article">
                            <i class="el-icon-circle-plus-outline"></i>
                            <span slot="title">添加文章</span>
                        </el-menu-item>
                        <el-menu-item
                                v-if="user_module_permission['article-category-read']"
                                index="/article-category">
                            <i class="el-icon-circle-plus-outline"></i>
                            <span slot="title">文章分类管理</span>
                        </el-menu-item>
                    </el-menu-item-group>
                </el-submenu>
                <el-submenu
                        v-if="user_module_permission['module-read']"
                        index="/module">
                    <template slot="title">
                        <i class="el-icon-menu"></i>
                        <span slot="title">菜单</span>
                    </template>
                    <el-menu-item-group>
                        <el-menu-item
                                v-if="user_module_permission['module-read']"
                                index="/module">
                            <i class="el-icon-tickets"></i>
                            <span slot="title">菜单列表</span>
                        </el-menu-item>
                        <el-menu-item
                                v-if="user_module_permission['add-module-read']"
                                index="/add-module">
                            <i class="el-icon-circle-plus-outline"></i>
                            <span slot="title">添加菜单</span>
                        </el-menu-item>
                    </el-menu-item-group>
                </el-submenu>
                <el-submenu
                        v-if="user_module_permission['user-read']"
                        index="/user">
                    <template slot="title">
                        <i class="el-icon-view"></i>
                        <span slot="title">用户管理</span>
                    </template>
                    <el-menu-item-group>
                        <el-menu-item
                                v-if="user_module_permission['add-user-read']"
                                index="/add-user">
                            <i class="el-icon-tickets"></i>
                            <span slot="title">添加用户</span>
                        </el-menu-item>
                        <el-menu-item
                                v-if="user_module_permission['add-role-read']"
                                index="/add-role">
                            <i class="el-icon-tickets"></i>
                            <span slot="title">添加角色</span>
                        </el-menu-item>
                        <el-menu-item
                                v-if="user_module_permission['role-user-read']"
                                index="/role-user">
                            <i class="el-icon-circle-plus-outline"></i>
                            <span slot="title">用户角色管理</span>
                        </el-menu-item>
                        <el-menu-item
                                v-if="user_module_permission['permission-read']"
                                index="/permission">
                            <i class="el-icon-circle-plus-outline"></i>
                            <span slot="title">权限管理</span>
                        </el-menu-item>
                    </el-menu-item-group>
                </el-submenu>
            </el-menu>
        </el-aside>
        <el-container>
            <el-header>
                <el-row class="header-row">
                    <el-col :span="8">
                        <h3>{{ message }}</h3>
                    </el-col>
                    <el-col :span="2" :offset="14" v-if="!login_user.user_id">
                        <router-link to="/login">登录</router-link>
                        <router-link to="/regist">注册</router-link>
                    </el-col>
                    <el-col :span="3" :offset="13" v-if="login_user.user_id">
                        欢迎你,
                        <el-popover
                                placement="bottom"
                                width="80"
                                trigger="click">
                            <div class="user-panel">
                                <el-button type="text" @click="logout">注销</el-button>
                            </div>
                            <el-button type="text" slot="reference">{{ login_user.nick_name }}</el-button>
                        </el-popover>
                    </el-col>
                </el-row>
            </el-header>
            <el-main>
                <router-view></router-view>
            </el-main>
            <el-footer></el-footer>
        </el-container>
    </el-container>
</template>

<script>
    import Vue from 'vue'
    import {mapState, mapActions} from 'vuex'
    import {Popover} from "element-ui"
    Vue.use(Popover)

    export default {
        name: "container",
        data() {
            return {
                isCollapse: true,
                message: '聚金CMS',
            }
        },
        computed: {
            ...mapState({
                'login_user': state=>state.user.login_user,
                'user_module_permission': state=>state.user.user_module_permission
            })
        },
        methods: {
            ...mapActions({
                'logout': 'user/logout'
            })
        },
        beforeCreate() {
            const userid = getCookie('userid'), nickname = getCookie('nickname');
            if(userid && nickname) {
                this.$store.commit('user/set_login_user', {
                    user_id: userid,
                    nick_name: nickname
                })

                this.$store.dispatch('user/get_user_module_permission')
                    .then(result=> {})
                    .catch(error=> {
                        this.$message.error(error)
                    })
            }
            else {
                this.$router.push({path: '/login'})
            }
        }
    }
</script>

<style scoped>
    .header-row {
        line-height: 38px;
    }
    .user-panel {
        text-align: center;
    }
</style>