
const state = {
    columns: {
        id: {title: "ID", show: true},
        time: {title: "更新时间", show: true},
        site: {title: "源站", show: true},
        state: {title: "当前状态", show: true}
    },
    lists: [],
    lists_all: [],
    pageSize:10,
    currentPage:1,
    total:0,
    state:-1,
    options:[]
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
            axios.get('/configInfo',{params: { 'key': 'manualCheck' }}).then(r=> {
                if(r.data.success === 1) {
                    let configData = r.data.data;
                    if(configData){
                        commit('set_list', configData);
                        commit('set_lists_all', configData);
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