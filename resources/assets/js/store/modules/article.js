const state = {
    current_page: 1,
    total: 0,
    per_page: 10,
    loading: false,
    article_lists: [],
    back_data: [],
    show_type: 3,
    types: [],
    body: '',
    article_now: {},
    columns: {
        id: {title: "ID", show: false},
        title: {title: "标题", show: true},
        description: {title: "描述", show: true},
        keywords: {title: "关键词", show: false},
        author: {title: "作者", show: true},
        publish_time: {title: "发布时间", show: true},
        image: {title: "封面图", show: true},
        type: {title: "分类", show: true},
        hits: {title: "点击量", show: true},
        url: {title: "链接", show: true},
        state: {title: "状态", show: true},
        favor: {title: "点赞人数", show: true},
        source_type: {title: "原创类型", show: true},
        source_url: {title: "来源链接", show: true},
        source_site: {title: "来源网站", show: true},
        created_time: {title: "创建时间", show: false},
        updated_time: {title: "更新时间", show: false},
    },
}
const mutations = {
    set_article_list: (state, article_lists) => {
        state.article_lists = article_lists;
    },
    set_back_data: (state, back_data) => {
        state.back_data = back_data;
    },
    set_current_page: (state, current_page) => {
        state.current_page = current_page
    },
    set_total: (state, total) => {
        state.total = total
    },
    set_per_page: (state, per_page) => {
        state.per_page = per_page
    },
    set_show_type: (state, show_type) => {
        state.show_type = show_type;
    },
    set_body: (state, body) => {
        state.body = body;
    },
    set_article_now: (state, article_now) => {
        state.article_now = article_now;
    },
    filte_data: (state) => {
        if(state.show_type == 3) state.article_lists = state.back_data;
        else
            state.article_lists = state.back_data.filter(x=>{
                return x.state == state.show_type;
            });

        state.total = state.article_lists.length;
    },
    update_article_list_by_index: (state, prop) => {
        state.article_lists[prop['index']][prop['key']] = prop['val']
    },
}
const getters = {
    type_filter: state=> {
        let types = [];
        for(let ar of state.article_lists) {
            if(!types.includes_by_key('value', ar['type'])) {
                types.push({text: ar['type'], value: ar['type']});
            }
        }

        return types;
    }
}
const actions = {
    get_data({ commit, state }) {
        return new Promise((resolve, reject)=> {
            axios.get("/article_lists").then(function(result){
                if(result.data.success === 1)
                {
                    commit('set_article_list', result.data.data)
                    commit('set_back_data', result.data.data)
                    // commit('filte_data')
                    commit('set_current_page', 1)
                    commit('set_total', result.data.data.length)
                }
            })
        })

    },
    set_article_state ({commit}, {id, state, index})  {
        return new Promise((resolve, reject)=> {
            axios.post('/setArticleState', {id: id, state: state})
                .then(function(result) {
                    if(result.data.success === 1) {
                        commit("update_article_list_by_index", {
                            index: index,
                            key: "state",
                            val: state
                        });

                        resolve()
                    }
                    else {
                        reject()
                    }
                });
        })
    },
    getArticle: function({commit}, id) {
        return new Promise((resolve, reject)=> {
            axios.get("/article_info?id="+id)
                .then(function(result){
                    if(result.data.success === 1) {
                        console.log(result.data.data)
                        commit('set_article_now', result.data.data)
                        let pattern = /\/uploads\/crawler/g;
                        commit('set_body', result.data.data.body.body.replace(pattern, 'http://images.jujin8.com/uploads'))

                        resolve()
                    }
                    else {
                        reject();
                    }
            });
        })
    },
}

export default {
    namespaced: true,
    state,
    mutations,
    getters,
    actions
}