<template>
    <div>
        <el-row>
            <el-col :span="6">
                <el-popover
                        placement="right"
                        width="400"
                        trigger="click">
                    <ul class="switch-panel">
                        <li v-for="(i, k) in columns">
                            <el-switch
                                    v-model="i.show"
                                    :active-text="i.title">
                            </el-switch>
                        </li>
                    </ul>
                    <el-button slot="reference">显示隐藏列</el-button>
                </el-popover>
            </el-col>
            <el-col :span="6">
                <el-radio-group v-model="show_type">
                    <el-radio-button label="3">全部</el-radio-button>
                    <el-radio-button label="1">上线</el-radio-button>
                    <el-radio-button label="0">下线</el-radio-button>
                </el-radio-group>
            </el-col>
        </el-row>
        <el-table :data="config_lists.slice((current_page-1)*per_page, current_page*per_page)"
                  v-loading="loading"
                  style="width: 100%">
            <el-table-column
                    prop="id"
                    sortable
                    :label="columns['id']['title']"
                    v-if="columns['id']['show']"
                    width="80">
            </el-table-column>
            <el-table-column
                    prop="key"
                    :label="columns['key']['title']"
                    v-if="columns['key']['show']" width="200">
            </el-table-column>
            <el-table-column
                    prop="value"
                    :label="columns['value']['title']"
                    v-if="columns['value']['show']"
                    width="*">
            </el-table-column>
            <el-table-column
                    prop="sequence"
                    :label="columns['sequence']['title']"
                    v-if="columns['sequence']['show']"
                    width="120">
            </el-table-column>
            <el-table-column
                    prop="group"
                    :label="columns['group']['title']"
                    v-if="columns['group']['show']"
                    width="160">
            </el-table-column>
            <el-table-column
                    prop="state"
                    sortable
                    :label="columns['state']['title']"
                    v-if="columns['state']['show']"
                    width="80">
                <template slot-scope="scope">
                    <div slot="reference" class="name-wrapper">
                        {{ scope.row.state==1?'已上线':'已下线' }}
                    </div>
                </template>
            </el-table-column>
            <el-table-column
                    prop="created_at"
                    :label="columns['created_time']['title']"
                    v-if="columns['created_time']['show']"
                    width="80">
            </el-table-column>
            <el-table-column
                    prop="updated_at"
                    :label="columns['updated_time']['title']"
                    v-if="columns['updated_time']['show']"
                    width="80">
            </el-table-column>
            <el-table-column label="操作" fixed="right" width="160">
                <template slot-scope="scope">
                    <el-button
                            size="mini"
                            :type="scope.row.state?'success':'danger'"
                            :disabled="!user_module_permission['config-delete']"
                            @click="setState(scope.$index, scope.row)">{{scope.row.state==1?"下线":"上线"}}</el-button>
                </template>
            </el-table-column>
        </el-table>
        <el-pagination
                background
                @current-change="page_change"
                @size-change="size_change"
                :current-page="current_page"
                layout="total, sizes, prev, pager, next, jumper"
                :total="total">
        </el-pagination>
        <el-dialog title="添加广告开关" :visible.sync="dialog_visible">
        </el-dialog>
    </div>
</template>

<script>
    import {mapState, mapActions, mapMutations} from 'vuex'
    import {Table, TableColumn, Pagination, Loading, Popover, Switch, RadioGroup, RadioButton, Dialog} from 'element-ui'
    Vue.use(Table);
    Vue.use(TableColumn);
    Vue.use(Pagination);
    Vue.use(Loading);
    Vue.use(Popover);
    Vue.use(Switch);
    Vue.use(RadioGroup);
    Vue.use(RadioButton);
    Vue.use(Dialog);

    export default {
        name: "config",
        computed: {
            ...mapState({
                'config_lists': state=>state.config.config_lists,
                'columns': state=>state.config.columns,
                'loading': state=>state.config.loading,
                'show_type': state=>state.config.show_type,
                'current_page': state=>state.config.current_page,
                'per_page': state=>state.config.per_page,
                'total': state=>state.config.total,
                'user_module_permission': state=>state.user.user_module_permission,
                'dialog_visible': state=>state.config.dialog_visible
            })
        },
        methods: {
            ...mapMutations({
                set_current_page: "config/set_current_page",
                set_per_page: "config/set_per_page",
                filte_data: "config/filte_data"
            }),
            ...mapActions({
                'get_config_lists': 'config/get_config_lists'
            }),
            page_change: function(page) {
                this.set_current_page(page)
            },
            size_change: function(size) {
                this.set_per_page(size);
            },
        },
        mounted() {
            const _this = this;
            this.get_config_lists().then(result=> {
                console.log(1234)
                console.log(_this.$store.state.config.config_lists)
            })
        }
    }


</script>

<style scoped>

</style>