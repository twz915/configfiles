import pytz
from dateutil import parser


def parse_http_datetime(s):
    try:
        dt = parser.parse(s)
        dt_china = dt.astimezone(pytz.timezone('Asia/Shanghai')).replace(tzinfo=None)
        return dt_china
    except:
        pass
    return None


if __name__ == '__main__':
    parse_http_datetime('Fri, 23 Mar 2018 01:30:12 GMT')
