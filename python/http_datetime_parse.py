from dateutil import parser


def parse_http_datetime(s):
    try:
        dt = parser.parse(s)
        dt_china = dt.astimezone(pytz.timezone('Asia/Shanghai')).replace(tzinfo=None)
        return dt_china
    except:
        pass
    return None
