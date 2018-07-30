import {check_integer_factory} from "../../plugin/tool";
import $ from 'jquery'
const state = {
    columns: {
        id: {title: "ID", show: true},
        is_handling: {title: "是否处理", show: true},
        content: {title: "内容", show: true},
        phone: {title: "电话", show: true},
        ip: {title: "IP", show: true},
        created_at: {title: "创建时间", show: true},
        updated_at: {title: "更新时间", show: true}
    },
    feed_lists: [],
    pageSize:10,
    currentPage:1,
    total:0
};

const mutations = {
    set_current_page: (state, current_page) => {
        state.currentPage = current_page;
    },
    set_page_size: (state, pageSize) => {
        state.pageSize = pageSize
    },
    set_feedback_list: (state, list) => {
        state.feed_lists = list
    }

};

const actions = {
    get_feed_lists: ({commit, state}) => {
        return new Promise((resolve, reject) => {
            axios.get('/api/feedback/getList?page='+(state.currentPage-1)+'&pageSize='+state.pageSize).then(result=> {
                if(result.data.success === 1) {
                    let data = result.data.data;
                    for(let o of data.list) {
                            if(o.is_handling==0){
                                o.is_handling=false;
                            }
                            else if(o.is_handling==1){
                                o.is_handling=true;
                            }
                    }
                    state.total = data.count;
                    commit('set_feedback_list', data.list);
                    resolve()
                }
                else reject()
            })
        })
    }
};

export default {
    namespaced: true,
    state,
    actions,
    mutations
}