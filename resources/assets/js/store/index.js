import Vue from "vue"
import Vuex from "vuex";
import user from "./modules/user"
import banner from "./modules/banner"
import banner_state from './modules/banner_state'
import module from './modules/module'
import article from './modules/article'
import config from './modules/config'
import hot_banner from './modules/hot_banner'
import company from './modules/company'
import category from './modules/category'
import category_company from './modules/category_company';
import live from './modules/kuaixun';

Vue.use(Vuex)
import actions from "./actions"
import mutations from "./mutations"
import getters from "./getters"

export default new Vuex.Store({
    modules: {
        user,
        banner,
        banner_state,
        module,
        article,
        config,
        hot_banner,
        company,
        category,
        category_company,
        live
    },
    state: {
        app_name: {},
        headers: {
            'X-Requested-With': 'XMLHttpRequest',
            'X-CSRF-TOKEN': document.head.querySelector('meta[name="csrf-token"]').content
        },
        formLabelWidth: '123px'
    },
    getters,
    mutations,
    actions
});