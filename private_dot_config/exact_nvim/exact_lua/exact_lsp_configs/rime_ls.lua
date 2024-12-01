return {
        init_options = {
                enabled = false,
                user_data_dir = "~/.local/share/nvim/rime-ls", -- 指定用户目录, 最好新建一个
                log_dir = "~/.cache/nvim/rime-ls",             -- 日志目录
                max_candidates = 10,                           -- [v0.2.0 后不再有用] 与 rime 的候选数量配置最好保持一致
                paging_characters = { ",", ".", "-", "=" },    -- [since v0.2.4] 这些字符会强制触发一次补全，可用于翻页 见 issue #13
                trigger_characters = {},                       -- 为空表示全局开启
                schema_trigger_character = "&",                -- [since v0.2.0] 当输入此字符串时请求补全会触发 “方案选单”
                always_incomplete = false,                     -- [since v0.2.3] true 强制补全永远刷新整个列表，而不是使用过滤
                max_tokens = 0,                                -- [since v0.2.3] 大于 0 表示会在删除到这个字符个数的时候，重建所有候选词，而不使用删除字符操作
                preselect_first = false,                       -- [since v0.2.3] 是否默认第一个候选项是选中状态，default false
        }
}
