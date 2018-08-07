
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
        return new Promise((resolve, reject) => {
            axios.get('/api/banner/list').then(result=> {
                if(result.data.success === 1) {
                    let data = result.data.data;
                    for(let o of data) {
                        if(o.state==0){
                            o.state=false;
                        }
                        else if(o.state==1){
                            o.state=true;
                        }
                    }
                    commit('set_list', data);
                    commit('set_lists_all', data);
                    resolve(data);
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