<template>
    <div>
        <el-container>
            <el-header>
                <h5>jujin8意见反馈列表</h5>
            </el-header>
            <el-main>
                <el-table
                        :data="feed_lists"
                        border
                        style="width: 100%">
                    <el-table-column
                            prop="id"
                            :label="columns['id']['title']"
                            v-if="columns['id']['show']"
                            width="180">
                    </el-table-column>
                    <el-table-column
                            prop="phone"
                            :label="columns['phone']['title']"
                            v-if="columns['phone']['show']"
                            width="180">
                    </el-table-column>
                    <el-table-column
                            prop="content"
                            :label="columns['content']['title']"
                            v-if="columns['content']['show']">
                    </el-table-column>
                    <el-table-column
                            prop="is_handling"
                            :label="columns['is_handling']['title']"
                            v-if="columns['is_handling']['show']">
                        <template slot-scope="scope">
                            <el-switch v-model="scope.row.is_handling"
                                       :disabled="!user_module_permission['feedback-delete']"
                                       @change="changeState(scope.row)"></el-switch>
                        </template>
                    </el-table-column>
                    <el-table-column
                            prop="created_at"
                            :label="columns['created_at']['title']"
                            v-if="columns['created_at']['show']">
                    </el-table-column>
                    <el-table-column
                            prop="updated_at"
                            :label="columns['updated_at']['title']"
                            v-if="columns['updated_at']['show']">
                    </el-table-column>
                    <el-table-column
                            prop="ip"
                            :label="columns['ip']['title']"
                            v-if="columns['ip']['show']">
                    </el-table-column>

                </el-table>
            </el-main>
        </el-container>
    </div>
</template>

<script>
    import {mapState, mapActions, mapMutations, mapGetters} from 'vuex'
    import {Table, TableColumn, Pagination, Loading, Popover, RadioGroup, RadioButton, Dialog, FormItem, Input, Select, Option, Switch, DatePicker, Upload, Form} from 'element-ui'
    Vue.use(FormItem);
    // Vue.use(Input);
    // Vue.use(Select);
    // Vue.use(Option);
    // Vue.use(Switch);
    // Vue.use(DatePicker);
    // Vue.use(Upload);
    // Vue.use(Form);
    Vue.use(Table);
    Vue.use(TableColumn);
    Vue.use(Pagination);
    Vue.use(Loading);
    // Vue.use(Popover);
    // Vue.use(RadioGroup);
    // Vue.use(RadioButton);
    // Vue.use(Dialog);
    export default {
        name: "feedback",
        data() {
            return {
            }
        },

        computed: {
            ...mapState(['headers', 'formLabelWidth']),
            ...mapState({
                'columns': state=>state.feedback.columns,
                'feed_lists': state=>state.feedback.feed_lists,
                'user_module_permission': state=>state.user.user_module_permission
            })
        },
        methods:{
            ...mapActions({
                'get_feed_lists': 'feedback/get_feed_lists'
            }),
            changeState: function (row) {
                const _this = this;
                console.log(row);
                // this.set_feed_state({id:row.id, state:row.state}).then(result=>{
                //     let message = row.state?"上线成功":"下线成功";
                //     _this.filte_data()
                //     _this.$message.success(message);
                // });
                // this.set_hot_banner_state({id:row.id, state:row.state}).then(result=>{
                //     let message = row.state?"上线成功":"下线成功";
                //     _this.filte_data()
                //     _this.$message.success(message);
                // });
            },
        },
        mounted(){
            //获取意见反馈列表
            var _this=this;
            this.get_feed_lists().then(result=> {
                _this.$message.success('成功获取意见反馈列表！');
            })
        }
    }
</script>

<style scoped>

</style>