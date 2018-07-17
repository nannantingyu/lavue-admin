const state = {
    columns: {
        id: {title: "ID", show: true},
        key: {title: "键", show: true},
        value: {title: "值", show: true},
        sequence: {title: "顺序", show: true},
        group: {title: "分组", show: true},
        state: {title: "状态", show: true},
        created_time: {title: "创建时间", show: false},
        updated_time: {title: "更新时间", show: false},
    },
    config_lists: [],
    show_type: 3,
    loading: false,
    current_page: 1,
    total: 0,
    per_page: 10,
    dialog_visible: false
};

const mutations = {
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
    set_config_list: (state, config_lists) => {
        state.config_lists = config_lists;
    },
    set_back_data: (state, back_data) => {
        state.back_data = back_data;
    },
};

const actions = {
    get_config_lists: ({commit, state}) => {
        return new Promise((resolve, reject) => {
            axios.get('/configLists').then(result=> {
                if(result.data.success === 1) {
                    commit('set_config_list', result.data.data)
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