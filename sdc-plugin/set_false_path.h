/*
 * Copyright (C) 2019-2022 The SymbiFlow Authors
 *
 * Use of this source code is governed by a ISC-style
 * license that can be found in the LICENSE file or at
 * https://opensource.org/licenses/ISC
 *
 * SPDX-License-Identifier: ISC
 */
#ifndef _SET_FALSE_PATH_H_
#define _SET_FALSE_PATH_H_

#include "kernel/register.h"
#include "kernel/rtlil.h"
#include "sdc_writer.h"

USING_YOSYS_NAMESPACE

struct SetFalsePath : public Pass {
    SetFalsePath(SdcWriter &sdc_writer) : Pass("set_false_path", "Set false path on net"), sdc_writer_(sdc_writer) {}

    void help() override;

    void execute(std::vector<std::string> args, RTLIL::Design *design) override;

    SdcWriter &sdc_writer_;
};

#endif //_SET_FALSE_PATH_H_
