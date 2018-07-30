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
    // to_booleans: ['is_handling']
};

const mutations = {
    set_current_page: (state, current_page) => {
        state.current_page = current_page
    },
    set_total: (state, total) => {
        state.total = total
    },
    set_feedback_list: (state, list) => {
        state.feed_lists = list
    }

};

const actions = {
    get_feed_lists: ({commit, state},pagePra, pageSizePra) => {
        let page = pagePra?pagePra:1;
        let pageSize=pageSizePra?pageSizePra:10;
        return new Promise((resolve, reject) => {
            axios.get('/api/feedback/getList?page='+page+'&pageSize='+pageSize).then(result=> {
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
                    console.log(data.list,"BBBBB");
                    commit('set_feedback_list', data.list);
                    resolve()
                }
                else reject()
            })
        })
    }
};

const getters = {
    fileimgs: state=> {
        let imgs = [];
        if(state.form.image)
            imgs.push({url: 'http://images.jujin8.com'+state.form.image.replace('/uploads/crawler', '/uploads')});

        return imgs;
    }
}

export default {
    namespaced: true,
    state,
    getters,
    actions,
    mutations
}