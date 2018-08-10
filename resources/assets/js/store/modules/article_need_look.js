import {check_time, check_integer_factory} from '../../plugin/tool'
const state = {
    // columns: {
    //     id: {title: "ID", show: true},
    //     time: {title: "更新时间", show: true},
    //     site: {title: "源站", show: true},
    //     state: {title: "当前状态", show: true}
    // },
    options:[{
        value: '选项1',
        label: '黄金糕'
    }, {
        value: '选项2',
        label: '双皮奶'
    }, {
        value: '选项3',
        label: '蚵仔煎'
    }, {
        value: '选项4',
        label: '龙须面'
    }, {
        value: '选项5',
        label: '北京烤鸭'
    }],
    lists: [],
    lists_all: [],
    pageSize:10,
    currentPage:1,
    total:0,
    state:-1,
    current_page: 1,
    per_page: 10,
    loading: false,
    article_lists: [],
    back_data: [],
    show_type: 3,
    article_now: {},
    editor: null,
    columns: {
        id: {title: "ID", show: true},
        title: {title: "标题", show: true},
        image: {title: "封面图", show: true},
        author: {title: "作者", show: true},
        publish_time: {title: "发布时间", show: true},
        url: {title: "链接", show: false},
        state: {title: "状态", show: true},
        recommend: {title: "推荐", show: false},
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
        categories: [],
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
    set_options:(state, options) => {
        state.options = options;
    },
    set_list: (state, list) => {
        state.lists = list;
    },
    set_lists_all: (state, list) => {
        state.lists_all = list;
    },
    filter_data: (state, r) => {
        // 0:全部
        // 1:自动审核
        // 2:人工审核
        if(r==0){
            state.lists = state.lists_all;
        }
        else if(r==1){
            let arr=[];
            state.lists_all.map((item)=>{
                if(!item.state){
                    arr.push(item);
                }
            })
            state.lists = arr;
        }
        else if(r==2){
            let arr=[];
            state.lists_all.map((item)=>{
                if(item.state){
                    arr.push(item);
                }
            })
            state.lists = arr;
        }
    }
};

const actions = {
    add_update:({commit, state},form) => {
        return new Promise((resolve, reject) => {
            axios.post('/api/banner/add',form).then(result=> {
                if(result.data.success === 1) {
                    let data = result.data.data;
                    resolve(data);
                }
                else reject(data)
            })
        })
    },
    get_options: ({commit, state}) => {
        //获取 网站审核数据
        return new Promise((resolve, reject) => {
                    axios.get('/configInfo',{params: { 'key': 'manualCheck' }}).then(r=> {
                        if(r.data.success === 1) {
                            let configData = r.data.data;
                            if(configData){
                                let arr=JSON.parse(configData.value);
                                commit('set_options', arr);
                                resolve(arr);
                            }
                            // console.log(r.data.data,"kkhhh")
                        }

                    })

        })
    },
    get_lists: ({commit, state}) => {
        //获取 网站审核数据 并组装
        return new Promise((resolve, reject) => {
            axios.get('/api/article/listBySite',{params: { size:10,
                    page:2,site:"jin10",time:"2015-01-01" }}).then(r=> {
                if(r.data.success === 1) {
                    let data = r.data.data;
                    if(data){
                        commit('set_list', data);
                        commit('set_total', data.count);
                        // commit('set_lists_all', configData);
                        resolve(configData);
                    }
                    // console.log(r.data.data,"kkhhh")
                }

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