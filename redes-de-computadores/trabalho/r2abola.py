from r2a.ir2a import IR2A
from player.parser import *
from base.whiteboard import Whiteboard
import math


class R2ABola(IR2A):

    def __init__(self, id):
        IR2A.__init__(self, id)

        self.V = None
        self.gamma_p = 5
        self.utilities = []
        self.qi = []
        self.whiteboard = Whiteboard.get_instance()

    def handle_xml_request(self, msg):
        self.send_down(msg)

    def handle_xml_response(self, msg):
        parsed_mpd = parse_mpd(msg.get_payload())
        self.qi = parsed_mpd.get_qi()

        # Utilidades
        self.utilities = [math.log(qi / self.qi[0]) for qi in self.qi]

        # V com multiplicador 1.2 para evitar travamento
        Qmax = self.whiteboard.get_max_buffer_size()
        base_V = (Qmax - 1) / (self.utilities[-1] + self.gamma_p)
        self.V = base_V * 1.2

        self.send_up(msg)

    def handle_segment_size_request(self, msg):
        Q = self.whiteboard.get_amount_video_to_play()

        max_ratio = -float('inf')
        selected_index = 0

        # Equação BOLA
        for m in range(len(self.qi)):
            numerator = self.V * self.utilities[m] + self.V * self.gamma_p - Q
            denominator = self.qi[m] / self.qi[0]
            ratio = numerator / denominator

            if ratio > 0 and ratio > max_ratio:
                max_ratio = ratio
                selected_index = m

        # Fallback natural
        if max_ratio < 0:
            selected_index = 0

        msg.add_quality_id(self.qi[selected_index])
        self.send_down(msg)

    def handle_segment_size_response(self, msg):
        self.send_up(msg)

    def initialize(self):
        pass

    def finalization(self):
        pass
