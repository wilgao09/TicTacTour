
from pyxsb import pyxsb_start_session, pyxsb_end_session, pyxsb_command, \
                  pyxsb_query, XSBFunctor, XSBVariable, xsb_to_json, json_to_xsb


pyxsb_start_session()
pyxsb_query("['tic_tac_toe.pl'].")

