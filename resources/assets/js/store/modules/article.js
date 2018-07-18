import {check_time, check_integer_factory} from '../../plugin/tool'

const state = {
    current_page: 1,
    total: 0,
    per_page: 10,
    loading: false,
    article_lists: [],
    back_data: [],
    show_type: 3,
    types: [],
    article_now: {},
    editor: null,
    columns: {
        id: {title: "ID", show: true},
        title: {title: "标题", show: true},
        image: {title: "封面图", show: true},
        description: {title: "描述", show: false},
        keywords: {title: "关键词", show: false},
        author: {title: "作者", show: true},
        publish_time: {title: "发布时间", show: true},
        type: {title: "分类", show: true},
        hits: {title: "点击量", show: true},
        url: {title: "链接", show: false},
        state: {title: "状态", show: true},
        recommend: {title: "推荐", show: false},
        favor: {title: "点赞人数", show: false},
        source_type: {title: "原创类型", show: false},
        source_url: {title: "来源链接", show: true},
        source_site: {title: "来源网站", show: true},
        created_at: {title: "创建时间", show: false},
        updated_at: {title: "更新时间", show: false},
    },
    rules: {
        title: [
            { required: true, message: '请输入标题', trigger: 'blur' },
            { min: 2, max: 64, message: '标题长度在 3 到 64 个字符', trigger: 'blur' }
        ],
        description: [
            { required: true, message: '请输入描述', trigger: 'blur' },
            { min: 2, max: 512, message: '描述在 3 到 512 个字符', trigger: 'blur' }
        ],
        keywords: [
            { max: 64, message: '关键词最多 16 个字符', trigger: 'blur' }
        ],
        author: [
            { max: 16, message: '作者最多 16 个字符', trigger: 'blur' }
        ],
        publish_time: [
            { validator: check_time("发布时间不正确"), trigger: 'change' }
        ],
        image: [
            { required: true, message: '请上传图片' },
        ],
        type: [
            { required: true, message: '请输入分类', trigger: 'blur' },
            { min: 2, max: 32, message: '分类在 3 到 32 个字符', trigger: 'blur' }
        ],
        hits: [
            { validator: check_integer_factory('点击量为数字类型'), trigger: 'blur' }
        ],
        favor: [
            { validator: check_integer_factory('点赞数为数字类型'), trigger: 'blur' }
        ],
        source_type: [
            { required: true, message: '请选择原创类型', trigger: 'blur' },
        ]
    },
    modules: [],
    form: {
        id: null,
        title: '',
        image: '',
        description: '',
        keywords: '',
        author: '',
        publish_time: '',
        type: '',
        hits: '',
        state: '',
        recommend: '',
        favor: 1,
        source_type: 'crawl',
        created_at: '',
        updated_at: ''
    },
    to_strings: [],
    to_booleans: ['state', 'recommend']
};

const mutations = {
    set_article_list: (state, article_lists) => {
        state.article_lists = article_lists;
    },
    set_back_data: (state, back_data) => {
        state.back_data = back_data;
    },
    set_editor: (state, editor) => {
        state.editor = editor;
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
    set_default_form: (state) => {
        state.form = {
            id: null,
            title: '',
            image: '',
            description: '',
            keywords: '',
            author: '',
            publish_time: '',
            type: '',
            hits: '',
            state: '',
            recommend: '',
            favor: 1,
            source_type: 'crawl',
            created_at: '',
            updated_at: ''
        }
    },
    set_form_value: (state, {key, value})=> {
        state.form[key] = value
    }
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
    },
    fileimgs: state=> {
        let imgs = [];
        if(state.form.image)
            imgs.push({url: 'http://images.jujin8.com'+state.form.image.replace('/uploads/crawler', '/uploads')});

        return imgs;
    }
};

const actions = {
    get_data({ commit, state }) {
        return new Promise((resolve, reject)=> {
            axios.get("/articleLists").then(function(result){
                if(result.data.success === 1)
                {
                    commit('set_article_list', result.data.data)
                    commit('set_back_data', result.data.data)
                    commit('set_current_page', 1)
                    commit('set_total', result.data.data.length)
                    resolve()
                }
                else reject()
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
    getArticle: function({state, commit}, id) {
        return new Promise((resolve, reject)=> {
            axios.get("/articleInfo?id="+id)
                .then(function(result){
                    if(result.data.success === 1) {
                        let value = ""
                        for (let o in result.data.data) {
                            if(state.form.hasOwnProperty(o)) {
                                value = result.data.data[o]
                                if(state.to_strings.includes(o))
                                    value = value?value.toString():value

                                else if(state.to_booleans.includes(o))
                                    value = value == 1 || !!value

                                commit('set_form_value', {key: o, value: value})
                            }
                        }

                        commit('set_article_now', result.data.data)
                        let pattern = /\/uploads\/crawler/g;
                        let body_add_strip = result.data.data.body.body.replace(pattern, 'http://images.jujin8.com/uploads');
                        state.editor.setValue(body_add_strip);
                        resolve()
                    }
                    else {
                        reject();
                    }
            });
        })
    },
    add_or_update_article({ commit, state }, form) {
        return new Promise((resolve, reject) => {
            let pattern = /http:\/\/images\.jujin8\.com\/uploads/g, body = state.editor.getValue();
            form.body = body.replace(pattern, '/uploads');
            form.state = form.state?1:0;
            form.recommend = form.recommend?1:0;

            axios.post("/addArticle", form).then(function(result){
                if(result.data.success === 1) {
                    resolve()
                }
                else {
                    reject()
                }
            });
        });
    }
}

export default {
    namespaced: true,
    state,
    mutations,
    getters,
    actions
}