
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
    state:-1
};

const mutations = {
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
    get_lists: ({commit, state}) => {
        //获取 网站审核数据 并组装
        return new Promise((resolve, reject) => {
            axios.get('/articleSource').then(result=> {
                if(result.data.success === 1) {
                    let allData = result.data.data;
                    axios.get('/configInfo',{params: { 'key': 'manualCheck' }}).then(r=> {
                        if(r.data.success === 1) {
                            let configData = r.data.data;
                            if(configData){
                                let arr=JSON.parse(configData.value);
                                arr.map((item)=>{
                                    allData.map((a)=>{
                                        if(item.site==a.source_site){
                                            a.state=1;
                                            a.time=item.time;
                                        }
                                    })

                                })
                                for(let o of allData) {
                                    if(o.state==0){
                                        o.state=false;
                                    }
                                    else if(o.state==1){
                                        o.state=true;
                                    }
                                }
                                commit('set_list', allData);
                                commit('set_lists_all', allData);
                                resolve(allData);
                            }
                            // console.log(r.data.data,"kkhhh")
                        }

                    })
                }
                else reject(data)
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