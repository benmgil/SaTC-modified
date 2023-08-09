from bug_finder.taint import main, setSinkTarget
from bug_finder.sinks import getfindflag, setfindflag
from taint_analysis.coretaint import setfollowTarget
import sys
import angr
import random
import string
import os

def convert_base(addr):
    return addr - 0x10000 + 0x400000

if __name__ == '__main__':
    proj = angr.Project(binary, auto_load_libs=False, use_sim_procedures=True)
    cfg = proj.analyses.CFG()


    try:
        start_func_addr_str = int("0x004011ad", 0)
        taint_addr = int("0x00402018", 0)
        callchain_addrs = ["0x00401176"] #NO ITS THE CALL NOT THE FUNCAHHHHHHHHHHHHHHH
        4gwg09gj0w439g3409gj340g9j4g09
        callchain_addrs = [int(j, 0) for j in callchain_addrs]
        sink_call_addrs = []

        start_func_addr = int(start_func_addr_str, 0)


        if proj.arch.name != "MIPS32":
            if not proj.loader.main_object.pic:
                start_addr = cfg.get_any_node(start_func_addr, anyaddr=True).addr
                callerbb = None
            else:
                callchain_addrs = [convert_base(j) for j in callchain_addrs]
                taint_addr = convert_base(taint_addr)
                sink_call_addrs = [convert_base(j) for j in sink_call_addrs]
                start_addr = cfg.get_any_node(convert_base(start_func_addr), anyaddr=True).addr
                callerbb = None
        else:
            if not proj.loader.main_object.pic or "system.so" in proj.filename:
                start_addr = cfg.get_any_node(start_func_addr, anyaddr=True).function_address
                callerbb = cfg.get_any_node(start_func_addr, anyaddr=True).addr
                with open(binary, 'rb') as f:
                    conttmp = f.read()
                    sec = proj.loader.main_object.sections_map['.got']
                    proj.loader.memory.write_bytes(sec.min_addr, conttmp[sec.offset: sec.offset + sec.memsize])
            else:
                callchain_addrs = [convert_base(j) for j in callchain_addrs]
                taint_addr = convert_base(taint_addr)
                sink_call_addrs = [convert_base(j) for j in sink_call_addrs]
                start_addr = cfg.get_any_node(convert_base(start_func_addr), anyaddr=True).function_address
                callerbb = cfg.get_any_node(convert_base(start_func_addr), anyaddr=True).addr
                with open(binary, 'rb') as f:
                    conttmp = f.read()
                    sec = proj.loader.main_object.sections_map['.got']
                    proj.loader.memory.write_bytes(sec.min_addr, conttmp[sec.offset: sec.offset + sec.memsize])

        sink_call_addrs = [cfg.get_any_node(j, anyaddr=True).addr for j in sink_call_addrs]
        callchain_cfg_nodes = [cfg.get_any_node(j, anyaddr=True).addr for j in callchain_addrs]

        setfindflag(False)
        setSinkTarget(sink_call_addrs)
        setfollowTarget(callchain_cfg_nodes)

        print "Analyzing %s from 0x%X, taint 0x%X, sinkTarget%s, functrace %s" % (
            binary, start_addr, taint_addr, str([hex(j) for j in sink_call_addrs]), str([hex(j) for j in callchain_cfg_nodes]))

        if not callerbb:
            main(start_addr, taint_addr, binary, proj, cfg)
        else:
            main(start_addr, taint_addr, binary, proj, cfg, callerbb)

        if getfindflag()[0]:
            print("WOOOO")

    except Exception as e:
        print e
